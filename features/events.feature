Feature: Events functionality

  I create events for calendar for couple of users

  @javascript
  Scenario: I create "day all" event and sync it for second user
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Confirmed firm user exists with first name "Second", last name "Second", email "litigo2test@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"
    And I login without firm
    When I add simple namespace
    And I activate calendars for simple namespace
    And I make sign out
    And I should be just login with email "litigo2test@gmail.com" and password "password"
    When I add second simple namespace
    And I activate calendars for second simple namespace
    And I make sign out
    And I login without firm
    And I go to events page
    And I add simple all_day event
    When I sync events
    And I make sign out
    And I should be just login with email "litigo2test@gmail.com" and password "password"
    And I go to events page
    And I sync events
    And I verify last synced events