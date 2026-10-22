# Changelog

All notable changes to the Varbase AI SEO recipe are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- The recipe: four AI automators for the SEO title and SEO description of Blog posts and Utility
  pages, the guarded ECA model `varbase_ai_seo_generate_metatags` (on save, bulk and custom event; an empty body is
  skipped) and the **AI SEO meta tags** bulk screen, plus `administer ai_automator` for Site Admin and SEO Admin (#1).
- GitHub Actions CI: lint, a Varbase 11 site, two applies, inline no-key checks including the empty-body guard, and
  the functional tests (#1).
- `docs/upstream-ai-automators-status.md`: proposed issue text for automators that run while disabled (#1).

### Changed
- No content types: the recipe no longer requires `varbase_blog_base` or `varbase_page_base`. It adds AI generation
  only to the Blog post and Utility page content types the site already has (#1).
- `drupal/varbase_ai_base` and `drupal/varbase_seo_base` are required at `~1.0.0` (#1).

### Checked
- CI on #2 (https://github.com/Vardot/varbase_ai_seo/actions/runs/38558296179): Varbase Starter 1.0.6, Drupal
  11.4.9, AI 1.5.0, ECA 3.1.9, AI Integration ECA 1.0.1, Metatag 2.2.0. Applied twice; every inline check passed and
  4 functional scenarios passed. With no AI provider in CI, a page with a body also saves with empty SEO fields, so
  the CI guard check proves that nothing is invented without a model, not the guard itself; that is local check 4.
- By hand on a local Varbase 11 site with a real model (14 October 2026): see the README's Checked table.

[Unreleased]: https://github.com/Vardot/varbase_ai_seo/commits/1.0.x
