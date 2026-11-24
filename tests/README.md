# Varbase functional testing suite

Playwright and Cucumber through [`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e), on a
Varbase 11 site with this recipe applied.

| Feature | Covers |
| --- | --- |
| `01-01-ai-seo-on-save.feature` | Empty SEO fields of a blog post are written by AI on save; the editor's own SEO title is kept; a post with no content gets none |
| `01-02-ai-seo-bulk.feature` | The SEO admin and site admin get the AI SEO meta tags page and its action |
| `01-03-ai-seo-accessibility.feature` | The blog form keeps the label, link name and ARIA rules |

The SEO group is a named selector in `tests/selectors/ai-seo-selectors.json`.

## Run it

```bash
npm install
LAUNCH_URL=https://your-site.ddev.site npm test
```

The site needs the webmaster (`webmaster`) and one user per role, named after the role (`content_editor`,
`content_admin`, `seo_admin`, `site_admin`), all with the password in `LOGIN_PASS` (default `dD.123123ddd`).
`.gitlab-ci.yml` shows the whole setup.

## AI provider

CI applies Drupal CMS AI before the recipe. It sets up an amazee.ai trial as the default provider, so no key
is needed and the SEO title and description are written by a real model.

When amazee.ai cannot be reached, `tests/scripts/ai-provider.sh` sets the AI module's Echo test provider
instead, prints "amazee.ai unavailable: running with the Echo test provider", exports `AI_PROVIDER=echoai` and
skips the scenarios tagged `@live-ai`, which need a real model's reply: the SEO fields written on save.
`AMAZEE_UNREACHABLE=1` forces that path. To skip them by hand: `CUCUMBER_TAGS="not @wip and not @live-ai" npm
test`.

The blog form is held to pinned accessibility rules rather than the full serious gate: the admin theme's help
toggles and CKEditor's toolbar menu items fail it, which comes from the theme and the editor, not this recipe.
