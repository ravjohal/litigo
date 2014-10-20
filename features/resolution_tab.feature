Feature: Resolution tab

  I create a case change the resolution and the changes are saved

    @javascript
  Scenario: I create a case and edit the resolution
    When I visit sign up page
    Given I am a logged in user with email "decider@gmail.com" and password "password"
    And when I fill in the modal window
    And I should logged in
    When I create a case
    And I create the resolution
    Then The resolution for user with email "decider@gmail.com" should be saved to the db
