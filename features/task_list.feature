Feature: Create Task List

  @javascript
  Scenario: I should be able to create Task List with task draft
    Given Confirmed default user exists
    When I login
    And I populate task list form
    And I click "Save"
    Then I check message "Task List was successfully added"
    And task list with task_draft should be created

  @javascript
  Scenario: I should be able to create Task List with manual import and task draft
    Given Confirmed default user exists
    When I login
    And I populate task list form manual
    And I click "Save"
    Then I check message "Task List was successfully added"
    And task list with manual and task_draft should be created

  @javascript
  Scenario: I should be able to create Task List with task draft and dependent task draft
    Given Confirmed default user exists
    When I login
    And I populate task list form
    And I add dependent task draft
    And I click "Save"
    Then task list with dependent task_draft should be created


