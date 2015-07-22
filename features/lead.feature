Feature: Create Lead Test

  I create a lead which gets saved

  @javascript
  Scenario: I create a lead
    When I sign up and login
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
    When I sign up and login
    And I click on "Caller Intake"
    And I create a lead with name "Leeds" and last name "United"
    And I click to element with id "accept"
    Then I check message "Medical injuries injury type can't be blank"
    And I check message "Case type can't be blank"
    When I click on "Edit"
    And I fill lead case fields
    And I click on "Save"
    Then I check message "Client intake was successfully updated."
    And I click to element with id "accept"
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
    And I click to element with id "accept"
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