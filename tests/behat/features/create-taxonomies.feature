Feature: Create taxonomies
  As a website user
  I want to create and link taxonomies

  Background:
    Given the "group" "EDITOR group" has permissions "CMS_ACCESS_LeftAndMain" and "TAXONOMYTERM_CREATE" and "TAXONOMYTERM_EDIT" and "TAXONOMYTERM_DELETE"

  Scenario: Create taxonomy terms, types and link them together
    # Only admins can create Taxonomy Types
    Given I am logged in with "ADMIN" permissions
    When I go to "/admin/taxonomy"
    When I click the "Taxonomy Types" CMS tab
    When I press the "Add Taxonomy Type" button
    And I fill in "Name" with "My taxonomy type"
    And I press the "Create" button
    When I follow "Taxonomy Types"
    Then I should see "My taxonomy type"

    # Login as editor to create taxonomy term
    When I go to "/Security/login"
    And I press the "Log in as someone else" button
    And I am logged in with "EDITOR" permissions
    When I go to "/admin/taxonomy"
    Then I should see the ".current[aria-controls='Taxonomy_Terms']" element
    When I press the "Add Taxonomy Term" button
    And I fill in "Name" with "My taxonomy term"
    And I select "My taxonomy type" from "Type"
    And I press the "Create" button
    When I follow "Taxonomy Terms"
    Then I should see "My taxonomy term"

    # Create child term
    When I click the "Edit" button in the "SilverStripe-Taxonomy-TaxonomyTerm" gridfield for the "My taxonomy term" row
    When I click the "Children" CMS tab
    When I press the "Add Taxonomy Term" button
    And I fill in "Name" with "My child taxonomy term"
    And I press the "Create" button
    When I follow "My taxonomy term"
    And I click the "Children" CMS tab
    Then I should see "My child taxonomy term"
    When I follow "Taxonomy Terms"
    Then I should not see "My child taxonomy term"
