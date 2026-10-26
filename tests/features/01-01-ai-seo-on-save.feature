@varbase-ai-seo @ai @recipes @local @development
Feature: Varbase AI Recipe - AI SEO - Filled on save, never overwritten
  As a content editor
  I want empty SEO fields filled when I save, and my own wording kept
  So that I get meta tags for free without losing what I wrote myself

  Background:
    Given I am a logged in user with the "Content editor" user

  Scenario: Verify empty SEO fields of a blog post are written on save
    CI has no real RAG or vector database hosting: it uses only what the pipeline has and the free amazee.ai
    trial from Drupal CMS AI (thanks to amazee.ai). Saving waits for the AI to write the SEO fields, which took
    11 to 14 seconds on a local site.
     When I go to "/node/add/blog"
      And I fill in "Title" with "SEO written on save"
      And I fill in "Description" with "A post that leaves its SEO fields empty."
      And I fill in the rich text editor field "Content" with "Varbase gives editors a fast way to publish accessible pages."
      And I click the "Save" button
      And I go to "/admin/content"
      And I open the "Edit" link in the "SEO written on save" row
     Then the field "SEO title" should not be empty
      And the field "SEO description" should not be empty

  Scenario: Verify an SEO title the editor wrote is kept
    CI has no real RAG or vector database hosting: it uses only what the pipeline has and the free amazee.ai
    trial from Drupal CMS AI (thanks to amazee.ai). Saving waits for the AI to write the SEO fields, which took
    11 to 14 seconds on a local site.
     When I go to "/node/add/blog"
      And I fill in "Title" with "SEO title kept on save"
      And I fill in "Description" with "A post with its own SEO title."
      And I fill in the rich text editor field "Content" with "Varbase gives editors a fast way to publish accessible pages."
      And I click SEO settings
      And I fill in "SEO title" with "Our own SEO title"
      And I click the "Save" button
      And I go to "/admin/content"
      And I open the "Edit" link in the "SEO title kept on save" row
      And I click SEO settings
     Then the "SEO title" field should contain "Our own SEO title"

  Scenario: Verify a blog post with no content gets no SEO text invented
     When I go to "/node/add/blog"
      And I fill in "Title" with "SEO skipped without content"
      And I fill in "Description" with "A post with no content yet."
      And I click the "Save" button
      And I go to "/admin/content"
      And I open the "Edit" link in the "SEO skipped without content" row
     Then the field "SEO title" should be empty
