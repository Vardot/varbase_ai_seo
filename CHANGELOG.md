# Changelog

All notable changes to the Varbase AI SEO recipe are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0-beta2] - 2026-10-29
### Added
- A Claude Code agent and skill for applying and verifying the recipe ([#3633905](https://www.drupal.org/i/3633905)).

### Changed
- Disable Drupal CMS telemetry in CI ([#3633862](https://www.drupal.org/i/3633862)).
- Update the version badge to `1.0.0-beta2` in `README.md`.

## [1.0.0-beta1] - 2026-10-27
### Added
- Automated functional acceptance tests for AI SEO and accessibility, run in CI on a fresh Varbase 11 site ([#3633139](https://www.drupal.org/i/3633139)).

### Changed
- Move the documentation to docs.varbase.vardot.com ([#3633012](https://www.drupal.org/i/3633012)).
- Install the Varbase Starter dev line in CI, which carries the search view fix for Drupal CMS Search 2.2.7.
- Update the version badge to `1.0.0-beta1` in `README.md`.

## [1.0.0-alpha1] - 2026-10-24
### Added
- Initialize Varbase AI SEO recipe ([#3632432](https://www.drupal.org/i/3632432)).
### Removed
- The GitHub Actions workflows and the `.github` templates: CI runs on git.drupalcode.org.

[Unreleased]: https://git.drupalcode.org/project/varbase_ai_seo/-/compare/1.0.0-beta2...1.0.x
[1.0.0-beta2]: https://git.drupalcode.org/project/varbase_ai_seo/-/compare/1.0.0-beta1...1.0.0-beta2
[1.0.0-beta1]: https://git.drupalcode.org/project/varbase_ai_seo/-/compare/1.0.0-alpha1...1.0.0-beta1
[1.0.0-alpha1]: https://git.drupalcode.org/project/varbase_ai_seo/-/tags/1.0.0-alpha1
