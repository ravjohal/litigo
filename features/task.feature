Feature: Task tab

  I create a case change the task and the changes are saved

  @javascript
  Scenario: I create a case and edit the task
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create a case
    And I create the task
    Then I should have text "Task successfully created."
    And The task for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I create a Task (not case tabs)
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create the task through case management
    Then I should have text "Task successfully created."
    And The task for user with email "artem.suchov@gmail.com" should be saved to the db with the right fields


  @javascript
  Scenario: I edit task
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist
    And Default task exist
    When I login without firm
    And I go to first task
    And I click "Edit"
    And I fill task form
    And I click "Save"
    Then I should have text "Task successfully updated."
    And The task should be edited success

  @javascript
  Scenario: I remove task
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist
    And Default task exist
    When I login without firm
    And I go to first task
    And I click to element with id "delete"
    And I confirm popup
    Then I should have text "Task successfully deleted."
    And User tasks should be empty for email "artem.suchov@gmail.com"