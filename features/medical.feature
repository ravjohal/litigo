Feature: Medical tab

  I create a case change the medical and the changes are saved

  @javascript
  Scenario: I create a case and edit the medical
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    And when I fill in the modal window
    And I should logged in
    And I create a case
#    And I create the medical
#    Then The medical for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I add edit the injury of the medical tab
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    And when I fill in the modal window
    And I should logged in
    And I create a case
#    And I create the injury
#    Then The injury for user with email "artem.suchov@gmail.com" should be saved to the db
