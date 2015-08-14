Feature: Create Lead Test

  I create a lead which gets saved

  @javascript
  Scenario: I create a lead
    Given Confirmed default user exists
    And Firm for default user exist
    When I login without firm
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    Then I check message "Client intake was successfully created."
    And I verify lead has been created for user: "artem.suchov@gmail.com"
    And I verify lead first name "Leeds" and last name "United" for user: "artem.suchov@gmail.com"
    When I edit lead
    Then I check message "Client intake was successfully updated."
    And I verify lead first name "Leeds 2" and last name "United 2" for user: "artem.suchov@gmail.com"
    When I delete lead
    Then I check message "Client intake was successfully destroyed."

  @javascript
  Scenario: I create a lead and accept case
    Given Confirmed default user exists
    And Firm for default user exist
    When I login without firm
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    And I click to element with id "accept"
    Then I check message "Medical injuries injury type can't be blank"
    And I check message "Case type can't be blank"
    When I click on "Edit"
    And I fill lead case fields
    And I click on "Save"
    Then I check message "Client intake was successfully updated."
    And I accept case
    Then I check message "Case was successfully created."
    And I verify lead case was created for user: "artem.suchov@gmail.com"

  @javascript
  Scenario: I create a lead, accept case and check case number
    Given Confirmed default user exists
    When I login
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    When I click on "Edit"
    And I fill lead case fields
    And I click on "Save"
    And I accept case
    Then I should have text "Case #: 1"
    When I create a case
    Then I should have text "Case #: 2"

  @javascript
  Scenario: I create a lead and edit fields
    Given Confirmed default user exists
    When I login
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    And I check lead text field "estimated_value" by "10" for user: "artem.suchov@gmail.com"
    And I check lead text field "lead_policy_limit" by "10" for user: "artem.suchov@gmail.com"
    And I check lead text field "case_summary" by "bla bla bla" for user: "artem.suchov@gmail.com"
    And I check lead text field "note" by "bla bla bla" for user: "artem.suchov@gmail.com"
    And I check lead text field "incident_date" by "2014-10-10" for user: "artem.suchov@gmail.com"
    And I check lead text field "appointment_date" by "2014-10-10" for user: "artem.suchov@gmail.com"
    And I check lead select field "marketing_channel" by "Referral" for user: "artem.suchov@gmail.com"
    And I check lead select field "case_type" by "Wrongful Death" for user: "artem.suchov@gmail.com"
    And I check lead select field "sub_type" by "Slip and Fall" for user: "artem.suchov@gmail.com"
    And I check lead select field "primary_injury" by "Dislocation" for user: "artem.suchov@gmail.com"
    And I check lead select field "primary_region" by "Face" for user: "artem.suchov@gmail.com"
    And I check lead select with option value "rejected" for field "status" by "Rejected" for user: "artem.suchov@gmail.com"
    And I check contact lead text field "first_name" by "Artem 2" for user: "artem.suchov@gmail.com"
    And I check contact lead text field "last_name" by "United 2" for user: "artem.suchov@gmail.com"
    And I check contact lead text field "attorney_name" by "bla bla" for user: "artem.suchov@gmail.com"
    And I check contact lead text field "dob" by "2014-10-10" for user: "artem.suchov@gmail.com"
#    And I check contact lead text field "ssn" by "4654654654" for user: "artem.suchov@gmail.com" # it isn't working now
    And I check contact lead text field "email" by "example@example.com" for user: "artem.suchov@gmail.com"
    And I check contact lead text field "address" by "bla bla" for user: "artem.suchov@gmail.com"
    And I check contact lead text field "city" by "bla bla" for user: "artem.suchov@gmail.com"
    And I check contact lead text field "zip_code" by "85454" for user: "artem.suchov@gmail.com"
    And I check contact lead select with option value "HI" for field "state" by "Hawaii" for user: "artem.suchov@gmail.com"

  @javascript
  Scenario: I create a lead and check tabs exist
    Given Confirmed default user exists
    When I login
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    And I click on "Caller Intake"
    And I click to element with selector "#user_leads > tbody > tr:first-child > td > a"
    Then should exist tab "DETAILS"
    And should exist tab "CONTACT"
    And should exist tab "DOCUMENTS"

  @javascript
  Scenario: I create a lead and check details tab
    Given Confirmed default user exists
    When I login
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    And I click on "Caller Intake"
    And I click to element with selector "#user_leads > tbody > tr:first-child > td > a"
    Then should exist tab "DETAILS"
    When I click on "DETAILS"
    Then I should have text "Lead Information"

  @javascript
  Scenario: I create a lead and check contact tab
    Given Confirmed default user exists
    When I login
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    And I click on "Caller Intake"
    And I click to element with selector "#user_leads > tbody > tr:first-child > td > a"
    Then should exist tab "CONTACT"
    When I click on "CONTACT"
    Then I should have text "Contact Information"

  @javascript
  Scenario: I create a lead and check documents tab
    Given Confirmed default user exists
    When I login
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    And I click on "Caller Intake"
    And I click to element with selector "#user_leads > tbody > tr:first-child > td > a"
    Then should exist tab "DOCUMENTS"
    When I click to tab "DOCUMENTS"
    Then I should have text "My Documents"
    And I should have text "Lead Documents"

  @javascript
  Scenario: I create a lead and check case data
    Given Confirmed default user exists
    When I login
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    When I click on "Edit"
    And I fill lead case fields
    And I fill lead case with incident fields
    And I click on "Save"
    Then I check message "Client intake was successfully updated."
    And I click to tab "Documents"
    When I add document for lead
    And I click to tab "Details"
    When I accept case
    Then I check message "Case was successfully created."
    And I verify accepted case with incident date for user: "artem.suchov@gmail.com"
    And I verify assigned contact "Attorney" for user "artem.suchov@gmail.com"
    And I verify assigned contact by type "Plaintiff" for user with first name "Leeds" and last name "United"
    And I verify case date of intake
    And I verify case type
    And I verify case sub type
    And I verify case injury
    And I verify case notes
    And I verify case resolution
    And I verify case summary
    And I verify case documents

  @javascript
  Scenario: I should be able to add document to lead
    Given Confirmed default user exists
    When I login
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    When I click on "Edit"
    And I fill lead case fields
    And I fill lead case with incident fields
    And I click on "Save"
    Then I check message "Client intake was successfully updated."
    And I click to tab "Documents"
    When I add document for lead
    Then I verify lead document

  @javascript
  Scenario: I should be able to change lead contact
    Given Confirmed default user exists
    When I login
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    When I click on "Edit"
    And I fill lead case fields
    And I fill lead case with incident fields
    And I click on "Save"
    Then I check message "Client intake was successfully updated."
    And I click to tab "Contact"
    When I edit lead contact
    Then I verify lead contact has been changed

  @javascript
  Scenario: I should be able to sort table in lead index page
    Given Confirmed default user exists
    And Firm for default user exist
    And Confirmed firm user exists with first name "Aaaaa", last name "Aaaaaaa", email "aaaaaaa@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"
    And Confirmed firm user exists with first name "Bbbbb", last name "Bbbbbbb", email "bbbbbbb@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"
    And Confirmed firm user exists with first name "Ccccc", last name "Ccccccc", email "ccccccc@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"
    And Exist advanced lead for user "artem.suchov@gmail.com" with name "FirstNameA" and "LastNameA" and date "08/08/2014" and estimated "100" and status "pending_review"
    And Exist advanced lead for user "artem.suchov@gmail.com" with name "FirstNameB" and "LastNameB" and date "09/09/2014" and estimated "200" and status "appointment_scheduled"
    And Exist difficult lead for user "artem.suchov@gmail.com" for attorney "aaaaaaa@gmail.com" with name "FirstNameAa" and "LastNameAa" and date "10/10/2014" and estimated "300" and status "appointment_scheduled"
    And Exist difficult lead for user "artem.suchov@gmail.com" for attorney "bbbbbbb@gmail.com" with name "FirstNameBb" and "LastNameBb" and date "11/11/2014" and estimated "400" and status "appointment_scheduled"
    And Exist difficult lead for user "artem.suchov@gmail.com" for attorney "ccccccc@gmail.com" with name "FirstNameCc" and "LastNameCc" and date "12/12/2014" and estimated "500" and status "pending_review"
    When I login without firm
    And I click on "Caller Intake"
    Then I verify sorted rows in table "user_leads" in column "1" by values "09/09/2014,08/08/2014"
    Then I verify sorted rows in table "leads" in column "1" by values "12/12/2014,11/11/2014,10/10/2014,09/09/2014,08/08/2014"
    When I click on table "user_leads" header "Call Date"
    Then I verify sorted rows in table "user_leads" in column "1" by values "08/08/2014,09/09/2014"
    When I click on table "leads" header "Call Date"
    Then I verify sorted rows in table "leads" in column "1" by values "08/08/2014,09/09/2014,10/10/2014,11/11/2014,12/12/2014"
#    When I click on table "leads" header "Assigned Attorney"
#    Then I verify sorted rows in table "leads" in column "2" by values "Aaaaa Aaaaaaa aaaaaaa@gmail.com,Bbbbb Bbbbbbb bbbbbbb@gmail.com,Ccccc Ccccccc ccccccc@gmail.com,Artem Suchov artem.suchov@gmail.com,Artem Suchov artem.suchov@gmail.com"
#    When I click on table "leads" header "Assigned Attorney"
#    Then I verify sorted rows in table "leads" in column "2" by values "Aaaaa Aaaaaaa aaaaaaa@gmail.com,Bbbbb Bbbbbbb bbbbbbb@gmail.com,Ccccc Ccccccc ccccccc@gmail.com,Artem Suchov artem.suchov@gmail.com,Artem Suchov artem.suchov@gmail.com"
    When I click on table "user_leads" header "Injured Party Name"
    Then I verify sorted rows in table "user_leads" in column "3" by values "FirstNameA LastNameA,FirstNameB LastNameB"
    When I click on table "user_leads" header "Injured Party Name"
    Then I verify sorted rows in table "user_leads" in column "3" by values "FirstNameB LastNameB,FirstNameA LastNameA"
    When I click on table "leads" header "Injured Party Name"
    Then I verify sorted rows in table "leads" in column "3" by values "FirstNameA LastNameA,FirstNameAa LastNameAa,FirstNameB LastNameB,FirstNameBb LastNameBb,FirstNameCc LastNameCc"
    When I click on table "leads" header "Injured Party Name"
    Then I verify sorted rows in table "leads" in column "3" by values "FirstNameCc LastNameCc,FirstNameBb LastNameBb,FirstNameB LastNameB,FirstNameAa LastNameAa,FirstNameA LastNameA"
    When I click on table "user_leads" header "Estimated Value"
    Then I verify sorted rows in table "user_leads" in column "4" by values "100,200"
    When I click on table "user_leads" header "Estimated Value"
    Then I verify sorted rows in table "user_leads" in column "4" by values "200,100"
    When I click on table "leads" header "Estimated Value"
    Then I verify sorted rows in table "leads" in column "4" by values "100,200,300,400,500"
    When I click on table "leads" header "Estimated Value"
    Then I verify sorted rows in table "leads" in column "4" by values "500,400,300,200,100"
    When I click on table "user_leads" header "Status"
    Then I verify sorted rows in table "user_leads" in column "5" by values "Appt. Scheduled,New Lead - Pending Review"
    When I click on table "user_leads" header "Status"
    Then I verify sorted rows in table "user_leads" in column "5" by values "New Lead - Pending Review,Appt. Scheduled"
    When I click on table "leads" header "Status"
    Then I verify sorted rows in table "leads" in column "5" by values "Appt. Scheduled,Appt. Scheduled,Appt. Scheduled,New Lead - Pending Review,New Lead - Pending Review"
    When I click on table "leads" header "Status"
    Then I verify sorted rows in table "leads" in column "5" by values "New Lead - Pending Review,New Lead - Pending Review,Appt. Scheduled,Appt. Scheduled,Appt. Scheduled"

  @javascript
  Scenario: I should be able to make search on lead index page
    Given Confirmed default user exists
    And Firm for default user exist
    And Confirmed firm user exists with first name "Aaaaa", last name "Aaaaaaa", email "aaaaaaa@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"
    And Confirmed firm user exists with first name "Bbbbb", last name "Bbbbbbb", email "bbbbbbb@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"
    And Confirmed firm user exists with first name "Ccccc", last name "Ccccccc", email "ccccccc@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"
    And Exist advanced lead for user "artem.suchov@gmail.com" with name "FirstNameA" and "LastNameA" and date "08/08/2014" and estimated "100" and status "pending_review"
    And Exist advanced lead for user "artem.suchov@gmail.com" with name "FirstNameB" and "LastNameB" and date "09/09/2014" and estimated "200" and status "appointment_scheduled"
    And Exist difficult lead for user "artem.suchov@gmail.com" for attorney "aaaaaaa@gmail.com" with name "FirstNameAa" and "LastNameAa" and date "10/10/2014" and estimated "300" and status "appointment_scheduled"
    And Exist difficult lead for user "artem.suchov@gmail.com" for attorney "bbbbbbb@gmail.com" with name "FirstNameBb" and "LastNameBb" and date "11/11/2014" and estimated "400" and status "appointment_scheduled"
    And Exist difficult lead for user "artem.suchov@gmail.com" for attorney "ccccccc@gmail.com" with name "FirstNameCc" and "LastNameCc" and date "12/12/2014" and estimated "500" and status "pending_review"
    When I login without firm
    And I click on "Caller Intake"
#    And I wait for "10" seconds
    And I fill case search field "user_leads" with "FirstNameA"
    Then I verify sorted rows in table "user_leads" in column "3" by values "FirstNameA"
    And I fill case search field "leads" with "FirstNameA"
    Then I verify sorted rows in table "leads" in column "3" by values "FirstNameAa,FirstNameA"