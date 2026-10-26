@varbase-ai-seo @ai @recipes @a11y @local @development @staging @production
Feature: Varbase AI Recipe - AI SEO - Accessible SEO fields
  As a content editor who uses assistive technology
  I want the blog form with its SEO fields to work with a keyboard and a screen reader
  So that I can review the SEO text like anyone else

  Scenario Outline: Check the blog form keeps the "<rule>" accessibility rule
    Given I am a logged in user with the "Content editor" user
     When I go to "/node/add/blog"
     Then the page should not violate the accessibility rule "<rule>"

    Examples:
      | rule              |
      | label             |
      | link-name         |
      | duplicate-id-aria |
      | aria-valid-attr   |
