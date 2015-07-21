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
    And I verify lead first name "Leeds 2" and last name "United 2" for user: "artem.suchov@gmail.com"
    Then I delete lead