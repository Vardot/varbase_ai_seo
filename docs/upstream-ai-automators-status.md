# Proposed upstream issue: ai_automators ignores an automator's status

Not filed. For the `drupal/ai` issue queue, component AI Automators.

> **Title:** A disabled automator still runs on entity save
>
> **Problem/Motivation:** `AiAutomatorEntityModifier::entityHasConfig()` (drupal/ai 1.4.7) loads every
> `ai_automator` for the entity's bundle and runs each one, whatever its `status` is. "Disable" in the automator
> list therefore does not stop a direct automator: the entity still gets its field filled, and the AI call is still
> paid for.
>
> **Steps to reproduce:** Create a direct automator on a text field, disable it, save an entity of that bundle with
> the field empty. The field is filled.
>
> **Proposed resolution:** Skip automators whose `status()` is FALSE when collecting them in `entityHasConfig()`
> (and wherever else the bundle's automators are loaded for processing), with a kernel test that a disabled
> automator does not run on save.

Found while building this recipe. The Varbase AI SEO recipe avoids it by shipping only `worker_type: action`
automators, run through its guarded ECA model.
