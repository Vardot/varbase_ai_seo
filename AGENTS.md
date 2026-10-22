# AGENTS.md

Guidance for AI coding agents working on the Varbase AI SEO recipe.

This is a **private** recipe on GitHub (`Vardot/varbase_ai_seo`), not a drupal.org project. Issues, pull requests and
CI all live on GitHub.

## Before you start

- **`README.md`**: what the recipe ships, how generation is triggered, the guard, the comparison with
  `ai_recipe_seo_optimizer`, and the AI Context follow-up shared with
  [Varbase AI Image Alt Context Base](https://github.com/Vardot/varbase_ai_image_alt_context_base).
- **`CHANGELOG.md`** and **`docs/`** (proposed upstream issue text).

## When you make a change

- One issue and one pull request per change. The PR says `Closes #<issue>` and ends with the Checkpoints list from
  `.github/pull_request_template.md`.
- Add an entry under `## [Unreleased]` in `CHANGELOG.md`.
- CI must be green before merging: `.github/workflows/ci.yml` applies the recipe twice on a real Varbase 11 site and
  runs the no-key checks inline, then the functional tests.
- Keep every generation path behind the empty-body guard, `overwrite: false`, and automators as `worker_type: action`
  (a direct automator runs even when disabled; see `docs/`).
- Keep the ECA model's `dependencies.config` listing the node types and fields it uses: the strict comparison on
  re-apply depends on it.
- No PHP in the repository, and no client's name, brand or terms in prompts or docs.
- Never bump the version or tag a release without explicit maintainer approval. Tags are three-segment (`1.0.0`)
  and are never moved once pushed.
