Feature: Resolution tab

  I create a case change the resolution and the changes are saved

    @javascript
  Scenario: I create a case and edit the resolution
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    And when I fill in the modal window
    And I should logged in
    And I create a case
    And I create the resolution
    Then The resolution for user with email "artem.suchov@gmail.com" should be saved to the db
