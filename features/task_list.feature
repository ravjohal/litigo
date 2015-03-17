Feature: Create Task List

  @javascript
  Scenario: I should be able to create Task List with task draft
    Given there is a user with the email "andrew@rubyriders.com", the first_name "Andrew", the last_name "Goncharenko" and the password "password" and the confirmed_at "2014-11-12 11:52:41.207207"
    When I log in with email "andrew@rubyriders.com" and password "password"
    And when I fill in the modal window
    And I populate task list form
    And I click "Save"
    Then task list with task_draft should be created

  @javascript
  Scenario: I should be able to create Task List with task draft and dependent task draft
    Given there is a user with the email "andrew@rubyriders.com", the first_name "Andrew", the last_name "Goncharenko" and the password "password" and the confirmed_at "2014-11-12 11:52:41.207207"
    When I log in with email "andrew@rubyriders.com" and password "password"
    And when I fill in the modal window
    And I populate task list form
    And I add dependent task draft
    And I click "Save"
    Then task list with dependent task_draft should be created

