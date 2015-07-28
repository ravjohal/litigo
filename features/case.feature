Feature: Case feature

  I create a case and Verify: Case Name, Case Number

  @javascript
  Scenario: I create a case and verify required fields
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    When I fill in the modal window
    And I should logged in
    And I create a case step by step
    Then I verify required fields for case for user with email "artem.suchov@gmail.com"

  @javascript
  Scenario: I can edit the details of the case
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    When I fill in the modal window
    And I should logged in
    And I create a case step by step
    And I verify required fields for case for user with email "artem.suchov@gmail.com"
    And I change the case fields
    Then I verify required fields for case for user with email "artem.suchov@gmail.com" are changed

  @javascript
  Scenario: Verify that the tabs are created: Details, Incident, Medical, Insurance, Contacts, Calendar, Tasks, Documents, Notes, Resolution
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    When I fill in the modal window
    And I should logged in
    And I create a case step by step
    And I wait for "10" seconds
    Then all tabs are created

  @javascript
  Scenario: I can assign Case Contacts and it should have message for assign same contact for several fields
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Confirmed firm user exists with first name "Dmitriy", last name "Svinin", email "dimmon908@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"
    When I should be just login with email "dimmon908@gmail.com" and password "password"
    And I click to user dropdown
    And I go to sign_out page
    And I login without firm
    And I create a case step by step
    And I click to tab "CONTACTS"
    And I click on "Edit"
    And I select "Artem Suchov" from "case_attorney"
    Then I should not see a JS alert
    When I select "Dmitriy Svinin" from "case_staff"
    Then I should not see a JS alert
    When I select "Artem Suchov" from "case_plaintiff"
    Then I should see a JS alert
    And I should see a "There is a contact on multiple roles, please confirm that is what you intended." JS alert dialog
    When I should close alert
    And I select "Dmitriy Svinin" from "case_judge"
    Then I should see a JS alert
    And I should see a "There is a contact on multiple roles, please confirm that is what you intended." JS alert dialog
    When I should close alert
    And I clear select "case_attorney"
    Then I should not see a JS alert
    When I select "Artem Suchov" from "case_attorney"
    Then I should see a "There is a contact on multiple roles, please confirm that is what you intended." JS alert dialog
    When I should close alert
    And I clear select "case_attorney"
    And I clear select "case_staff"
    And I clear select "case_plaintiff"
    And I clear select "case_judge"
    And I select "Artem Suchov" from "case_attorney"
    Then I should not see a JS alert
    When I select "Dmitriy Svinin" from "case_staff"
    Then I should not see a JS alert
    When I click on "Save"
    Then I should have text "Contact was successfully updated."

  @javascript
  Scenario: I can assign Case Contacts and verify it save successfully
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Confirmed firm user exists with first name "Dmitriy", last name "Svinin", email "dimmon908@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"
    When I should be just login with email "dimmon908@gmail.com" and password "password"
    And I click to user dropdown
    And I go to sign_out page
    And I login without firm
    And I create a case step by step
    And I wait for "1" seconds
    And I click to tab "CONTACTS"
    And I should have text "Case Contacts"
    And I click on "Edit"
    And I select "Artem Suchov" from "case_attorney"
    And I select "Dmitriy Svinin" from "case_staff"
    And I select "Artem Suchov" from "case_plaintiff"
    And I should close alert
    And I select "Dmitriy Svinin" from "case_judge"
    And I should close alert
    And I click on "Save"
    Then I should have text "Contact was successfully updated."
    And I verify assigned contact "Attorney" for user "artem.suchov@gmail.com"
    And I verify assigned contact "Staff" for user "dimmon908@gmail.com"
    And I verify assigned contact "Plaintiff" for user "artem.suchov@gmail.com"
    And I verify assigned contact "Judge" for user "dimmon908@gmail.com"