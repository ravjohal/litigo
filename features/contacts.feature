Feature: Contact tab

  I create a case change the contact and the changes are saved

  @javascript
  Scenario: I create a case and create the contact
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    And when I fill in the modal window
    And I should logged in
    And I create a case
    And I create the contact
    Then The contact for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I create a Contact (not case tabs)
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    And when I fill in the modal window
    And I should logged in
    And I create the contact trough the case management
    Then The contact for user with email "artem.suchov@gmail.com" should be saved to the db with the right fields
