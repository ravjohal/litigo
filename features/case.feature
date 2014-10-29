Feature: Case feature

  I create a case and Verify: Case Name, Case Number

  @javascript
  Scenario: I create a case and verify required fields
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    And when I fill in the modal window
    And I should logged in
    And I create a case step by step
    Then I verify required fields for case for user with email "artem.suchov@gmail.com"

  @javascript
  Scenario: I can edit the details of the caise
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    And when I fill in the modal window
    And I should logged in
    And I create a case step by step
    And I verify required fields for case for user with email "artem.suchov@gmail.com"
    And I change the case fields
    Then I verify required fields for case for user with email "artem.suchov@gmail.com" are changed
