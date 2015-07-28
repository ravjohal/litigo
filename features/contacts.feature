Feature: Contact tab

  I create a case change the contact and the changes are saved

  @javascript
  Scenario: I create a case and create the contact
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    When I fill in the modal window
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
    When I fill in the modal window
    And I should logged in
    And I create the contact trough the case management
    Then The contact for user with email "artem.suchov@gmail.com" should be saved to the db with the right fields


  @javascript
  Scenario: I edit the contact
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    And I go to contacts
    And I click on "Suchov Artem"
    And I click on "Edit"
    And I fill edit contact form
    And I click "Save"
    Then I should have text "Company was successfully created."
    And The contact info should be saved

  @javascript
  Scenario: I should delete the contact
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    And I go to contacts
    And I click on "Suchov Artem"
    And I click to element with id "delete"
    And I confirm popup
    Then I should have text "Contact was successfully destroyed."
    And User contacts should be empty for email "artem.suchov@gmail.com"