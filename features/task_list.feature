Feature: Create Task List

  @javascript
  Scenario: I should be able to create Task List with task draft
    Given Confirmed default user exists
    And Firm for default user exist
    When I login without firm
    And I populate task list form
    And I click "Save"
    Then I check message "Task List was successfully added"
    And task list with task_draft should be created

  @javascript
  Scenario: I should be able to create Task List with manual import and task draft
    Given Confirmed default user exists
    And Firm for default user exist
    When I login without firm
    And I populate task list form manual
    And I click "Save"
    Then I check message "Task List was successfully added"
    And task list with manual and task_draft should be created

  @javascript
  Scenario: I should be able to create Task List with task draft and dependent task draft
    Given Confirmed default user exists
    And Firm for default user exist
    When I login without firm
    And I populate task list form
    And I add dependent task draft
    And I click "Save"
    Then task list with dependent task_draft should be created

  @javascript
  Scenario: I should receive error message whlie try to import without select any list
    Given Confirmed default user exists
    And Firm for default user exist
    And Default case exist
    When I login without firm
    And I click "Case Management"
    And I go to first firm case
    And I go to import saved task list
    And I click "IMPORT TASK LIST(S)"
    Then I should have text "Please select task lists to import"

  @javascript
  Scenario: I should be able to create Task List with task draft and import that to case
    Given Confirmed default user exists
    And Firm for default user exist
    And Default case exist
    When I login without firm
    And I populate task list form
    And I click "Save"
    And I go to first firm case
    And I go to import saved task list
    And I fill import list
    And I click "IMPORT TASK LIST(S)"
    And I wait for "0.5" seconds
    Then I should have message "Task list(s) were successfully imported"
    And task list without dependent task_draft should be imported

  @javascript
  Scenario: I should be able to create Task List with task draft and dependent and import that to case
    Given Confirmed default user exists
    And Firm for default user exist
    And Default case exist
    When I login without firm
    And I populate task list form
    And I add dependent task draft
    And I click "Save"
    And I go to first firm case
    And I go to import saved task list
    And I fill import list
    And I click "IMPORT TASK LIST(S)"
    And I wait for "0.5" seconds
    Then I should have message "Task list(s) were successfully imported"
    And task list with dependent task_draft should be imported

  @javascript
  Scenario: I should be able to create couple of Task Lists and import those to case
    Given Confirmed default user exists
    And Firm for default user exist
    And Default case exist
    When I login without firm
    And I populate task list form
    And I add dependent task draft
    And I click "Save"
    And I click "Case Management"
    And I populate task list form
    And I click "Save"
    And I go to first firm case
    And I go to import saved task list
    And I fill import list
    And I click "IMPORT TASK LIST(S)"
    And I wait for "0.3" seconds
    Then I should have message "Task list(s) were successfully imported"
    And task list should contain tasks from couple lists