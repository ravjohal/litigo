Feature: Create Task List

  @javascript
  Scenario: I should be able to create Task List
    Given there is a user with the email "andrew@rubyriders.com", the first_name "Andrew", the last_name "Goncharenko" and the password "password" and the confirmed_at "2014-11-12 11:52:41.207207"
    When I log in with email "andrew@rubyriders.com" and password "password"
    And when I fill in the modal window
    Then I click "Case Management"
    And I click "TASKS"
    And I click "Task List"
    And I click "Create New List"
    And I fill Task List form
    Then task list with task_drafts should be created
