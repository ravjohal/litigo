Feature: Incident tab

  I create a case change the incident and the changes are saved

  @javascript
  Scenario: I create an contact and create the incident
    Given Confirmed default user exists
    And Firm for default user exist
    When I login without firm
    And I create a medical case
    And I create the incident
    Then I should have message "incident was successfully updated."
    And The incident for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I create an incident for case and edit it
    Given Confirmed default user exists
    And Firm for default user exist
    And Default medical case exist
    When I login without firm
    And I click on "Case Management"
    And I go to first firm case
    And I click to tab "INCIDENT"
    And I wait for "0.3" seconds
    And I click on "Edit"
    And I fill incident form field
    And I click on "Save"
    Then I should have message "incident was successfully updated."
    And I verify saved case incident
    When I click on "Edit"
    And I fill incident form field for update
    And I click on "Save"
    Then I should have message "incident was successfully updated."
    And I verify updated case incident
