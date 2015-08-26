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

  @javascript
  Scenario: I create event for two users and try to update participants
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    When I add simple namespace
    Then I should have created namespace for user "artem.suchov@gmail.com"
    When I activate calendars for simple namespace
    Then Calendar should by synced for user "artem.suchov@gmail.com"

  @javascript
  Scenario: I should be able to have event modal window
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    And I open case management menu
    And I go to calendar events page
    And I open create event popup
    And I wait for "0.3" seconds
    Then I should have text "Calendar Event"

  @javascript
  Scenario: I should be able to create event without calendar
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    And I open case management menu
    And I go to calendar events page
    And I open create event popup
    And I fill event without calendar
    And I wait for "0.2" seconds
    Then I should have message "Event was successfully created."
    And I verify calendar event was created
    When I click to element by javascript with selector "div.fc-event"
    And I wait for "0.2" seconds
    Then I verify created event shown fields

  @javascript
  Scenario: I should be able to create event with calendar
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    When I add simple namespace
    And I activate calendars for simple namespace
    And I open case management menu
    And I go to calendar events page
    And I open create event popup
    And I fill event with calendar
    And I wait for "0.2" seconds
    Then I verify event with calendar event was created
    And I verify event placed to nylas

#  @javascript
#  Scenario: I create event for two users and try to update participants
#    Given Confirmed default admin user exists
#    And Firm for default user exist
#    And Confirmed firm user exists with first name "Second", last name "Second", email "litigo2test@gmail.com" and password "password" for user with email "artem.suchov@gmail.com"
#    And I login without firm
#    When I add simple namespace
#    And I activate calendars for simple namespace
#    And I make sign out
#    And I should be just login with email "litigo2test@gmail.com" and password "password"
#    When I add second simple namespace
#    And I activate calendars for second simple namespace
#    And I make sign out
#    And I login without firm
#    And I go to events page
#    And I add simple all_day event
#    When I sync events
#    And I make sign out
#    And I should be just login with email "litigo2test@gmail.com" and password "password"
#    And I go to events page
#    And I sync events
#    And I make sign out
#    And I login without firm
#    And I go to events page
#    And I remove participant in event "Simple event"
#    And I sync events
#    And I make sign out
#    And I should be just login with email "litigo2test@gmail.com" and password "password"
#    And I go to events page
#    When I sync events
#    Then I should verify removed event to user "litigo2test@gmail.com"
