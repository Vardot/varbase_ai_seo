@varbase-ai @seo @recipe
Feature: The Varbase AI SEO recipe adds the AI SEO bulk screen
  As a Varbase SEO editor
  I want a screen listing content with missing SEO titles and descriptions
  So that I can generate them in bulk with AI

  Scenario: The Webmaster opens the AI SEO meta tags screen
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/content/ai-seo-metatags"
    Then I should see "AI SEO meta tags"
     And I the page should not have PHP errors

  Scenario: The SEO automators are listed
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/config/ai/ai-automators"
    Then I the page should not have PHP errors

  Scenario: A user without the content overview permission is kept out
    Given I am a logged in user with the "Authenticated user" user
    When I navigate to "/admin/content/ai-seo-metatags"
    Then I should not see "AI SEO meta tags"
     And I the page should not have PHP errors
