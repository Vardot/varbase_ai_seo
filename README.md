[![Varbase](https://raw.githubusercontent.com/Vardot/varbase/11.0.x/images/varbase-logo.png)](https://www.drupal.org/project/varbase)

# Varbase AI SEO
[![Varbase AI SEO](https://img.shields.io/badge/Varbase%20AI%20SEO-1.0.0--alpha1-0d6efc?labelColor=001d38&style=flat-square)](https://www.drupal.org/project/varbase_ai_seo)

An **opt-in** Drupal recipe that generates the **SEO title** and **SEO description** of Blog posts and
Utility pages with AI: when a node is saved, and in bulk over existing content.

## Documentation

Read the [Varbase AI SEO documentation](https://docs.varbase.vardot.com/developers/understanding-varbase/varbase-ai-recipes/varbase-ai-seo) on the Varbase docs site.

## Install and apply

```bash
ddev composer config --json extra.drupal-recipe-unpack.ignore '["drupal/varbase_ai_seo"]'
ddev composer require drupal/varbase_ai_seo:~1

# Recipes do not enforce config dependencies, so check the fields exist first.
ddev drush eval 'var_dump((bool) \Drupal\field\Entity\FieldConfig::loadByName("node", "blog", "field_seo_title"));'

ddev drush recipe ../recipes/varbase_ai_seo
ddev drush cr
```

Re-applying is safe. When the project already ignores
other packages for recipe unpack, add to that list rather than replacing it.

## Automated testing

GitLab CI on [git.drupalcode.org](https://git.drupalcode.org/project/varbase_ai_seo) (`.gitlab-ci.yml`) builds
a Varbase 11 site, applies this recipe twice and runs the Varbase functional testing suite in `tests/` on it. See
[tests/README.md](tests/README.md) to run it against a site of your own.

## License

GPL-2.0-or-later. See [LICENSE](LICENSE). Maintained by [Vardot](https://www.vardot.com).
