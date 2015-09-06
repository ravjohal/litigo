Feature: Task tab

  I create a case change the task and the changes are saved

  @javascript
  Scenario: I create a case and edit the task
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create a case
    And I create the task
    Then I should have message "Task successfully created."
    And The task for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I create a Task (not case tabs)
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create the task through case management
    Then I should have message "Task successfully created."
    And The task for user with email "artem.suchov@gmail.com" should be saved to the db with the right fields

#  @javascript
#  Scenario: I should see both calendar while create task
#    Given Confirmed default admin user exists
#    And Firm for default user exist
#    And Default namespace exist for default user
#    And Default calendar exist for default user
#    And Default calendar exist for default user
#    When I login without firm
#    And I open create task modal
#    Then select "task_calendar_id" should have "2" options

#  @javascript
#  Scenario: I should see only active calendar while create task
#    Given Confirmed default admin user exists
#    And Firm for default user exist
#    And Default namespace exist for default user
#    And Default calendar exist for default user
#    And Default disabled calendar exist for default user
#    When I login without firm
#    And I open create task modal
#    Then select "task_calendar_id" should have "1" option

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
    Then I should have message "Task successfully updated."
    And The task should be edited success

  @javascript
  Scenario: I remove task
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default case exist
    And Default task exist
    When I login without firm
    And I go to first task
    And I push delete button
    Then I should have message "Task successfully deleted."
    And User tasks should be empty for email "artem.suchov@gmail.com"