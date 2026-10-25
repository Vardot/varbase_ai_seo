# AGENTS.md

Guidance for AI coding agents working on the Varbase AI SEO recipe.

This is a drupal.org project: [drupal.org/project/varbase_ai_seo](https://www.drupal.org/project/varbase_ai_seo).
Issues live in its [issue queue](https://www.drupal.org/project/issues/varbase_ai_seo) and merge requests on
[git.drupalcode.org](https://git.drupalcode.org/project/varbase_ai_seo). Its default branch is `1.0.x`; the
GitHub repository is a mirror and takes no issues or pull requests.

## Before you start

- **Documentation** lives on the Varbase docs site: [docs.varbase.vardot.com](https://docs.varbase.vardot.com/developers/understanding-varbase/varbase-ai-recipes/varbase-ai-seo). Keep `README.md` short and link there; add no `docs/` folder.
- **`CHANGELOG.md`**: what changed in each release, newest first.

## When you make a change

- One drupal.org issue and one issue-fork merge request per change, titled `<type>: #<issue> Summary`. The MR
  description ends with the Checkpoints list from `.gitlab/merge_request_templates/default.md`.
- CI must be green before merging: `.gitlab-ci.yml` on git.drupalcode.org validates `composer.json` and lints
  every YAML file.
- Add an entry under `## [Unreleased]` in `CHANGELOG.md`.
- Keep every generation path behind the empty-body guard, `overwrite: false`, and automators as `worker_type: action`
  (a direct automator runs even when disabled).
- Keep the ECA model's `dependencies.config` listing the node types and fields it uses: the strict comparison on
  re-apply depends on it.
- No PHP in the repository, and no client's name, brand or terms in prompts or docs.
- All configuration lives in `recipe.yml` and the recipe's own `config/`, never in `config/install` or `config/optional`.
- Never bump the version or tag a release without explicit maintainer approval. Tags are three-segment (`1.0.0`)
  and are never moved once pushed.
