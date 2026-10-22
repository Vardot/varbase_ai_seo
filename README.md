[![Varbase](https://raw.githubusercontent.com/Vardot/varbase/11.0.x/images/varbase-logo.png)](https://www.drupal.org/project/varbase)

# Varbase AI SEO
[![Varbase AI SEO](https://img.shields.io/badge/Varbase%20AI%20SEO-1.0.x--dev-0d6efc?labelColor=001d38&style=flat-square)](https://www.drupal.org/project/varbase_ai_seo)

An **opt-in** Drupal recipe that generates the **SEO title** and **SEO description** of Blog posts and
Utility pages with AI: when a node is saved, and in bulk over existing content.

On Varbase those two fields already drive every text meta tag through
`metatag.metatag_defaults.node` (from `varbase_seo_base`):

| Tag | Source |
| --- | --- |
| `<title>` | `[node:field_seo_title\|node:title] \| [site:name]` |
| `description` | `[node:field_seo_description\|node:field_description]` |
| `og:title`, `twitter:title` | `[node:field_seo_title\|node:title]` |
| `og:description`, `twitter:description` | `[node:field_seo_description\|node:field_description]` |

So filling the two fields fills six tags, with no second metatag field and no LLM
call at page render. Configuration only, no custom code.

Generalised from a client project's recipe, with one behaviour
fixed (see "Every path is guarded").

## What it ships

| Config | Purpose |
| --- | --- |
| `ai_automators.ai_automator.node.{blog,page}.field_seo_{title,description}.bulk` | the four prompts, as action workers |
| `eca.eca.varbase_ai_seo_generate_metatags` | runs them on save, in bulk and on request, behind one guard |
| `views.view.varbase_ai_seo` | **Content → AI SEO meta tags** (`/admin/content/ai-seo-metatags`), the bulk screen |

Plus `administer ai_automator` for `site_admin` and `seo_admin`, so the people who
own SEO can tune the prompts. Fields, form displays and metatag defaults are NOT
shipped, and no content type is added: they come from the site's own Varbase install
(the metatag defaults from `varbase_seo_base`).

## How generation is triggered

| Path | Trigger | Notes |
| --- | --- | --- |
| On save | `content_entity:presave` for `node blog` / `node page` | fills only empty fields, in the same save |
| Bulk, both fields (preferred) | VBO action *AI: SEO title and description (guarded)* | saves each node once |
| Bulk, one field | VBO actions *AI: SEO title (blog, bulk)* etc. | the plain automators, no guard |
| On request | `content_entity:custom` with `event_id: generate_seo_metatags` | for code, other models, integrations |

`overwrite: false` everywhere: an editor's own wording is never replaced, and a
filled field costs no AI call on later saves. Bulk `batch_size` is 1, because each
row is a live LLM call.

### Every path is guarded

The guard is `eca_entity_field_value_empty` on `field_content`, negated: a node with
an empty body is skipped, rather than given a meta title invented from its title.

The client recipe guarded only the ECA path and filled on save with plain
`worker_type: direct` automators. Tested here, a Utility page saved with an empty
body came back with *"A test page on the Varbase Demo 1 site, used to check how the
main content field is rendered…"*: invented. So on save now also goes through the
ECA model and the direct automators are gone. The per-field bulk actions remain
unguarded by design; use the guarded one.

Found on the way, for upstream (`drupal/ai`, `ai_automators` 1.4.7): an automator's
**status is ignored** at save time. `AiAutomatorEntityModifier::entityHasConfig()`
loads every automator for the bundle and runs it, whatever its enabled flag says, so
"Disable" in the UI does not stop a direct automator. Proposed issue text:
[docs/upstream-ai-automators-status.md](docs/upstream-ai-automators-status.md).

## Compared with the Drupal AI demo's "AI SEO Optimizer"

The demo's *Recommended AI Recipes* tab lists `drupal/ai_recipe_seo_optimizer`.
Checked 14 October 2026:

| | `ai_recipe_seo_optimizer` 0.1.1 | `varbase_ai_seo` |
| --- | --- | --- |
| Release | 0.1.1, 3 Dec 2025 | — |
| Requires a dev release | **yes**, `drupal_cms_seo_tools: ^2.x-dev` | no |
| New modules | `custom_field`, `custom_field_ai`, `field_widget_actions`, `token_entity_render` | none beyond the Varbase AI stack |
| Title + description | yes, per field, via widget buttons | yes |
| SEO report / score | yes: `field_ai_seo_analysis`, a 12-section audit prompt over `[node:render:full]` | no: Varbase already scores with Yoast SEO, without an LLM |
| Content types | every bundle (`createForEachIfNotExists`) | Blog post, Utility page |
| Bulk | no | yes |
| Guard against thin content | no | yes |

Per the Varbase AI layering rule (wrap only what is stable and security
covered), it is **not wrapped**: a dev-release dependency, and four extra modules
for what `ai_automators` already does. Worth taking from it, as a phase 2:
**Generate buttons on the field** (`field_widget_actions`, security covered), so an
editor sees a proposal before saving. That is what the demo shows; this recipe
fills on save instead.

## Context-aware

This recipe is "context-aware": it makes an AI feature that sits outside the agent pipeline follow the
site's AI Context (Context Control Center: brand, editorial, safety).

Testing found that this context reaches only callers that ask for it. The same applies here: on `ai_context`
1.0.0-beta4 these automators get none. On `ai_context` 1.0.0-rc1 the Automator consumer type exists and routes on the
`ai_automator:id:{id}` request tag, with push **off** by default.

**Next step, documented, not implemented:** once Varbase is on rc1, enable push for the four automators with an
`ai_context.consumers` config action, the same shape the alt text recipe uses, one row per automator:

```yaml
ai_context.consumers:
  simpleConfigUpdate:
    consumers.0:
      consumer_id: 'automator:node.blog.field_seo_title.bulk'
      type: automator
      push_enabled: true
      always_include: []
      never_include: []
      selection_mode: inherit
    # consumers.1 to consumers.3: the same for node.blog.field_seo_description.bulk,
    # node.page.field_seo_title.bulk and node.page.field_seo_description.bulk.
```

The `consumer_id` follows the rc1 Automator type (type `automator`, instance id = the automator id), read from
`AiContextConsumerTypeAutomator`. Before doing it, check that `ai_integration_eca_automators` sends the `ai_automator:id:{id}` tag on the ECA path, and the row-index
caveat the alt text recipe documents. Both recipes writing `consumers.0` would collide; they need distinct rows, or the
upstream ai_context change proposed there.

## Requirements

A Varbase 11 site: the Blog post and Utility page content types with `field_seo_title` and `field_seo_description`
(already on the site from its Varbase install), the metatag
defaults (`varbase_seo_base`), and a default `chat` provider in `ai.settings` (`varbase_ai_base`). No key is stored in
the recipe.

**This recipe does not add content types**, and does not require the recipes that do: neither under `recipes:` nor in
`composer.json`. It only adds AI generation to content types the site already has (see the comment in `recipe.yml`).

## Install and apply

```bash
ddev composer config --json extra.drupal-recipe-unpack.ignore '["drupal/varbase_ai_seo"]'
ddev composer require drupal/varbase_ai_seo:1.0.x-dev

# Recipes do not enforce config dependencies, so check the fields exist first.
ddev drush eval 'var_dump((bool) \Drupal\field\Entity\FieldConfig::loadByName("node", "blog", "field_seo_title"));'

ddev drush recipe ../recipes/varbase_ai_seo
ddev drush cr
```

Re-applying is safe. When the project already ignores
other packages for recipe unpack, add to that list rather than replacing it.

## Automated testing

GitLab CI on [git.drupalcode.org](https://git.drupalcode.org/project/varbase_ai_seo) (`.gitlab-ci.yml`) runs on every merge
request and every push to `1.0.x`, like the other Varbase AI recipes: `composer validate` and a lint of every YAML
file.

The functional tests in `tests/features` (Playwright and Cucumber through
[`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e)) run against a site of your own:
`yarn install`, then `LAUNCH_URL=https://your-site.ddev.site yarn test`.

## Checked

14 October 2026, a local Varbase 11 site (Drupal 11.4, PHP 8.4, DDEV),
default chat provider Anthropic, real model calls:

| # | Check | Result |
| --- | --- | --- |
| 1 | Applies three times in a row | pass |
| 2 | Blog post saved with body, empty SEO fields | title 50 chars, description 154 chars |
| 3 | Editor overrides the title, saves twice | override kept, 0 AI calls |
| 4 | Utility page saved with an empty body | both fields empty, 0 AI calls |
| 5 | Custom event on that empty page | untouched, 0 AI calls |
| 6 | Body added, saved | both fields filled, 2 AI calls |
| 7 | Event fired again on a filled node | unchanged, 0 AI calls |
| 8 | Rendered page | `<title>`, description, og and twitter tags all from the two fields |
| 9 | Bulk screen | guarded action listed first, 4 per-field actions after; 403 for anonymous |

Not verified: the bulk actions run from a browser, multilingual output on this
site, and the four Vardot site templates.

## Related recipes

| Recipe | What it does |
|---|---|
| [Varbase AI Content Review Base](https://www.drupal.org/project/varbase_ai_content_review_base) | AI review agents for editorial quality and brand voice. |

## License

GPL-2.0-or-later. See [LICENSE](LICENSE). Maintained by [Vardot](https://www.vardot.com).
