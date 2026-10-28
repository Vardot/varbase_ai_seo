---
name: varbase-ai-seo
description: "Apply, repair and verify Varbase AI SEO on a Varbase 11 site: AI SEO titles and descriptions for Blog posts and Utility pages, on save and in bulk (Varbase AI SEO). Install and apply commands, inputs, config, post-apply steps, browser checks, traps and versions, read from the recipe code. Use when adding, fixing or checking Varbase AI SEO."
---

# Varbase AI SEO

Read from `recipe.yml`, `composer.json`, README, CHANGELOG and `git log` at the latest tag, 28 October 2026. Re-check versions on drupal.org before relying on them. For the full Varbase AI apply order, see the Varbase AI recipes docs page.

## Recipes

| Recipe | Latest | Stability | Require |
|---|---|---|---|
| `varbase_ai_seo` | 1.0.0-beta1 | beta | `drupal/varbase_ai_seo:~1` |

Docs (the code wins where they differ):
- https://docs.varbase.vardot.com/developers/understanding-varbase/varbase-ai-recipes/varbase-ai-seo

## What it does

- Installs `ai`, `ai_automators`, `ai_integration_eca`, `ai_integration_eca_automators`, `eca`, `eca_content`, `eca_vbo`, `metatag`, `modeler_api`, `node`, `views`, `views_bulk_operations`. Grants `site_admin`, `seo_admin`.
- Strict config (fails if it already exists differently): automators `node.blog.field_seo_title.bulk`, `node.blog.field_seo_description.bulk`, `node.page.field_seo_title.bulk`, `node.page.field_seo_description.bulk`; ECA model `varbase_ai_seo_generate_metatags`; view `varbase_ai_seo` (bulk).
- Composer: `varbase_ai_base ~1.0.0`, `varbase_seo_base ~1.0.0`, `ai ^1.4`, `ai_integration_eca ^1.0@RC`, `eca ^3.1`, `eca_vbo ^2.2`, `metatag ^2.2`, `modeler_api ^1.0`, `views_bulk_operations ^4.4`. No inputs.

## Apply

All commands in DDEV, from the project root; recipes are applied from the docroot path `../recipes/<name>`. Take a snapshot first: `ddev snapshot --name before-varbase-ai-seo`. Add each recipe to `extra.drupal-recipe-unpack.ignore` in `composer.json` before requiring it (read the list first: `composer config --json` replaces it).

```bash
ddev drush ev 'var_dump((bool) \Drupal\field\Entity\FieldConfig::loadByName("node","blog","field_seo_title"));'   # must be true
ddev composer require drupal/varbase_ai_seo:~1
ddev drush cr
ddev drush recipe ../recipes/varbase_ai_seo -y
ddev drush cr
```

## After the apply

- Templates without a Blog type: add one first (Varbase Blog Base), or skip this recipe and finish its Blog steps later.
- Run the bulk view once for existing content (one AI call per item).

## Verify

- Save a blog post with empty SEO fields: both fill in; the page source shows them in the meta title, description, Open Graph and Twitter tags.

Test as a real editor or visitor, not user 1: a superuser bypasses permissions.

## Traps

- Recipes do not enforce config dependencies: check `field_seo_title` and `field_seo_description` exist on `blog` and `page` before the apply.
- One AI call per saved item: turn the automators off for bulk imports.

## History

Started 22 Oct 2026, 1.0.0-alpha1 24 Oct, 1.0.0-beta1 27 Oct (functional tests #3633139).
