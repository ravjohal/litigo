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