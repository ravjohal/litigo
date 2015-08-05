Feature: Namespaces functionality

  I add a namespace

  @javascript
  Scenario: I create namespace and verify it
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    When I add simple namespace
    Then I verify simple namespace created for user "artem.suchov@gmail.com"
    And I verify downloading calendar for user "artem.suchov@gmail.com"

  @javascript
  Scenario: I create namespace and add event to it
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    When I add simple namespace
    And I activate calendars for simple namespace
    And I go to tasks
    And I create the task with calendar
    Then I verify namespace event count for user "artem.suchov@gmail.com"

  @javascript
  Scenario: I add namespace and try to delete it
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    When I add simple namespace
    And I activate calendars for simple namespace
    And I go to tasks
    And I create the task with calendar
    And I delete simple namespace
    Then I should have message "Namespace was successfully destroyed."
    And I verify deleted namespace for user "artem.suchov@gmail.com"

  @javascript
  Scenario: I add namespace and try to delete calendar
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    When I add simple namespace
    And I activate calendars for simple namespace
    And I go to tasks
    And I create the task with calendar
    And I delete simple namespace calendar
    Then I should have message "Calendar was successfully destroyed."
    And I verify deleted calendar for user "artem.suchov@gmail.com"


