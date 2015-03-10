Feature: Create Lead Test

  I create a lead which gets saved

  @javascript
  Scenario: I create a lead
    When Signup and Login
    And I click on and create lead
    Then I verify lead has been created for user: "artem.suchov@gmail.com"
    Then I edit lead
    Then I verify lead has been changed for user: "artem.suchov@gmail.com"
    Then I delete lead