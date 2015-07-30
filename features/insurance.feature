Feature: Insurance tab

  I create a case change the insurance and the changes are saved

  @javascript
  Scenario: I create a medical case and create the incident, edit the incident and delete the incident
    Given Confirmed default user exists
    And Firm for default user exist
    And Default medical case exist
    When I login without firm
    And I click on "Case Management"
    And I go to first firm case
    And I click to tab "INSURANCE"
    And I wait for "0.3" seconds
    And I click on "Edit"
    And I add insurance row with type: "Type1", holder: "Holder1", claim_number: "1111111", policy_limit: "1000"
    And I add insurance row with type: "Type2", holder: "Holder2", claim_number: "2222222", policy_limit: "2000"
    And I click on "Save"
    Then I should have message "insurance was successfully updated."
    And I verify case insurances count "2"
    And I verify saved case insurances with index "0" and fields "Type1", "Holder1", "1111111", "1000"
    And I verify saved case insurances with index "1" and fields "Type2", "Holder2", "2222222", "2000"
    And I case insurances total should be "3000"
    When I click on "Edit"
    And I change insurance row "1" field "insurance_type" with "NewType1"
    And I change insurance row "2" field "policy_limit" with "3000"
    And I click on "Save"
    Then I should have message "insurance was successfully updated."
    And I verify saved case insurances with index "0" and fields "NewType1", "Holder1", "1111111", "1000"
    And I verify saved case insurances with index "1" and fields "Type2", "Holder2", "2222222", "3000"
    And I case insurances total should be "4000"
    When I click on "Edit"
    And I remove insurance row "1"
    And I click on "Save"
    Then I should have message "insurance was successfully updated."
    And I verify case insurances count "1"
    And I verify saved case insurances with index "0" and fields "Type2", "Holder2", "2222222", "3000"
    And I case insurances total should be "3000"