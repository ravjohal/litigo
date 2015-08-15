Feature: Case feature

  I create a case and Verify: Case Name, Case Number

  @javascript
  Scenario: I create a case and verify required fields
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    And I create a case step by step
    Then I verify required fields for case for user with email "artem.suchov@gmail.com"

  @javascript
  Scenario: I create a couple of cases and verify case numbers
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    And I create a case step by step
    Then I verify required fields for case for user with email "artem.suchov@gmail.com"
    And I click on "CASES"
    And I create a second case
    Then I verify required fields for second case for user with email "artem.suchov@gmail.com"

  @javascript
  Scenario: I can edit the details of the case
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    And I create a case step by step
    And I verify required fields for case for user with email "artem.suchov@gmail.com"
    And I change the case fields
    Then I verify required fields for case for user with email "artem.suchov@gmail.com" are changed

  @javascript
  Scenario: Verify that the tabs are created: Details, Incident, Medical, Insurance, Contacts, Calendar, Tasks, Documents, Notes, Resolution
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    And I create a case step by step
    Then all tabs are created

  @javascript
  Scenario: Verify that the tabs are created including medical
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    And I create a medical case step by step
    Then all tabs are created includint medical

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
    Then I should have message "Contact was successfully updated."

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
    Then I should have message "Contact was successfully updated."
    And I verify assigned contact "Attorney" for user "artem.suchov@gmail.com"
    And I verify assigned contact "Staff" for user "dimmon908@gmail.com"
    And I verify assigned contact "Plaintiff" for user "artem.suchov@gmail.com"
    And I verify assigned contact "Judge" for user "dimmon908@gmail.com"

  @javascript
  Scenario: I check case details tab
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create a case step by step detailed
    Then I should have message "Case was successfully created."
    And I verify required fields for detailed case for user with email "artem.suchov@gmail.com"
    And I wait for "0.2" seconds
    And I verify case details tab
    When I click on "Edit"
    And I fill case details form
    And I click "Save"
    Then I verify case details updated for user "artem.suchov@gmail.com"

  @javascript
  Scenario: I should be able to delete case
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist
    And I login without firm
    And I open case management menu
    And I go to first firm case
    And I push delete button
    Then I should have message "Case was successfully deleted."
    And I verity deleted case for user "artem.suchov@gmail.com"

  @javascript
  Scenario: I should be able to open case through index page
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist
    And I login without firm
    And I open case management menu
    And I go to first firm case
    Then I should have text "Case #: 1"

  @javascript
  Scenario: I should be able to open case index page and see firm cases are sorted on # in descending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with name "Name1"
    And Default case exist with name "Name2"
    And Default case exist with name "Name3"
    And I login without firm
    And I go to cases
    Then I verify sorted firm cases on descending #

  @javascript
  Scenario: I should be able to open case index page and see own cases are sorted on # in descending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with name "Name1"
    And Default case exist with name "Name2"
    And Default case exist with name "Name3"
    And I login without firm
    And I go to cases
    Then I verify sorted own cases on descending #

  @javascript
  Scenario: I should be able to sort cases alphabetically in descending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with name "Abc"
    And Default case exist with name "Bcd"
    And Default case exist with name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "user_cases" header "Case Name"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically in ascending for "user_cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in ascending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with name "Abc"
    And Default case exist with name "Bcd"
    And Default case exist with name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "user_cases" header "Case Name"
    And I wait for "1" seconds
    And I click on table "user_cases" header "Case Name"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically in descending for "user_cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in type by ascending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with type and name "Abc"
    And Default case exist with type and name "Bcd"
    And Default case exist with type and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "user_cases" header "Case Type"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically type in ascending for "user_cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in type by descending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with type and name "Abc"
    And Default case exist with type and name "Bcd"
    And Default case exist with type and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "user_cases" header "Case Type"
    And I wait for "1" seconds
    And I click on table "user_cases" header "Case Type"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically type in descending for "user_cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in summary by ascending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with summary and name "Abc"
    And Default case exist with summary and name "Bcd"
    And Default case exist with summary and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "user_cases" header "Case Summary"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically summary in ascending for "user_cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in summary by descending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with summary and name "Abc"
    And Default case exist with summary and name "Bcd"
    And Default case exist with summary and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "user_cases" header "Case Summary"
    And I wait for "1" seconds
    And I click on table "user_cases" header "Case Summary"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically summary in descending for "user_cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in status by ascending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with status and name "Abc"
    And Default case exist with status and name "Bcd"
    And Default case exist with status and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "user_cases" header "Status"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically status in ascending for "user_cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in status by descending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with status and name "Abc"
    And Default case exist with status and name "Bcd"
    And Default case exist with status and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "user_cases" header "Status"
    And I wait for "1" seconds
    And I click on table "user_cases" header "Status"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically status in descending for "user_cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in descending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with name "Abc"
    And Default case exist with name "Bcd"
    And Default case exist with name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "cases" header "Case Name"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically in ascending for "cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in ascending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with name "Abc"
    And Default case exist with name "Bcd"
    And Default case exist with name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "cases" header "Case Name"
    And I wait for "1" seconds
    And I click on table "cases" header "Case Name"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically in descending for "cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in type by ascending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with type and name "Abc"
    And Default case exist with type and name "Bcd"
    And Default case exist with type and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "cases" header "Case Type"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically type in ascending for "cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in type by descending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with type and name "Abc"
    And Default case exist with type and name "Bcd"
    And Default case exist with type and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "cases" header "Case Type"
    And I wait for "1" seconds
    And I click on table "cases" header "Case Type"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically type in descending for "cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in summary by ascending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with summary and name "Abc"
    And Default case exist with summary and name "Bcd"
    And Default case exist with summary and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "cases" header "Case Summary"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically summary in ascending for "cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in summary by descending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with summary and name "Abc"
    And Default case exist with summary and name "Bcd"
    And Default case exist with summary and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "cases" header "Case Summary"
    And I wait for "1" seconds
    And I click on table "cases" header "Case Summary"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically summary in descending for "cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in status by ascending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with status and name "Abc"
    And Default case exist with status and name "Bcd"
    And Default case exist with status and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "cases" header "Status"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically status in ascending for "cases"

  @javascript
  Scenario: I should be able to sort cases alphabetically in status by descending order
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with status and name "Abc"
    And Default case exist with status and name "Bcd"
    And Default case exist with status and name "Cde"
    And I login without firm
    And I go to cases
    And I click on table "cases" header "Status"
    And I wait for "1" seconds
    And I click on table "cases" header "Status"
    And I wait for "1" seconds
    Then I verify sorted cases alphabetically status in descending for "cases"

  @javascript
  Scenario: I should be able to make search in own user cases
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with status and name "Abc"
    And Default case exist with status and name "Bcd"
    And Default case exist with status and name "Bca"
    And Default case exist with status and name "Cde"
    And I login without firm
    And I go to cases
    And I fill case search field "user_cases" with "Ab"
    Then I should have cases "1" in table "user_cases"
    When I fill case search field "user_cases" with "bc"
    Then I should have cases "3,2" in table "user_cases"

  @javascript
  Scenario: I should be able to make search in firm cases
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist with status and name "Abc"
    And Default case exist with status and name "Bcd"
    And Default case exist with status and name "Bca"
    And Default case exist with status and name "Cde"
    And I login without firm
    And I go to cases
    And I fill case search field "cases" with "Ab"
    Then I should have cases "1" in table "cases"
    When I fill case search field "cases" with "bc"
    Then I should have cases "3,2" in table "cases"

  @javascript
  Scenario: It should display 3 last notes in case summary
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist
    And Create note for default case with note "Note11111" and date "08/08/2014"
    And Create note for default case with note "Note22222" and date "09/09/2014"
    And Create note for default case with note "Note33333" and date "10/10/2014"
    And Create note for default case with note "Note44444" and date "11/11/2014"
    And I login without firm
    And I open case management menu
    And I go to first case
    And I wait for "0.1" seconds
    And I click to tab "Summary"
    Then I should have last notes "Note44444,Note33333,Note22222"

  @javascript
  Scenario: It should verify case total medicals
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default medical case exist
    And Create medical bill for default case with amount "1000", "1000", "1000"
    And Create medical bill for default case with amount "2000", "2000", "2000"
    And I login without firm
    And I open case management menu
    And I go to first case
    And I wait for "0.1" seconds
    And I click to tab "Summary"
    Then I verify case total medicals to "$3,000.00"