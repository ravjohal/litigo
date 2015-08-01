Feature: Home page

  I visit home page like a guest and I see the sing up suggestion and free trial button

  Scenario: I visit home page as a guest
    Given I am a guest
    When I visit home page
    Then the page should show "LEGAL INSIGHTS TO BUILD A WINNING CASE"
