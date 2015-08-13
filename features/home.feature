Feature: Home page

  I visit home page like a guest and I see the sing up suggestion and free trial button

  Scenario: I visit home page as a guest
    Given I am a guest
    When I visit home page
    Then the page should show "LEGAL INSIGHTS TO BUILD A WINNING CASE"

  @javascript
  Scenario: I visit home page and click "start trial"
    Given I am a guest
    When I visit home page
    And I click on "START FREE TRIAL"
    And I fill in the sign up form with valid data
    Then I should receive confirmation email for user "artem.suchov@gmail.com"
    Then I get the confirmation email and confirm it
    And I should be logged in user
    When I fill in the modal window
    Then I should logged in

  @javascript
  Scenario: I should be able to resend confirm email
    Given I am a guest
    When I visit home page
    And I click on "START FREE TRIAL"
    And I fill in the sign up form with valid data
    Then I should receive confirmation email for user "artem.suchov@gmail.com"
    When I click to element with selector ".glyphicon-send"
    And I wait for "0.3" seconds
    Then I should receive confirmation email for user "artem.suchov@gmail.com"
    Then I get the confirmation email and confirm it
    And I should be logged in user
    When I fill in the modal window
    Then I should logged in