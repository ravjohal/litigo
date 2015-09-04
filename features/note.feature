Feature: Note tab

  I create a case change the note and the changes are saved

  @javascript
  Scenario: I create a case and create the note
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create a case
    And I create a note from case
    Then The case note for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I create a note
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create a note
    Then The note for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I delete a note
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create a note
    Then The note for user with email "artem.suchov@gmail.com" should be saved to the db
    When I delete a note
    Then I should have message "Note was successfully deleted"
    And I verify deleted note for user with email "artem.suchov@gmail.com"

#  @javascript
#  Scenario: I create a note with task
#    Given Confirmed default admin user exists
#    And Firm for default user exist
#    When I login without firm
#    And I create a note with task
#    Then The note with task for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I edit a note
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Default note exist
    When I login without firm
    And I go to first note
    And I click "Edit"
    And I edit a note
    And I click on "Save"
    Then The note should be edited for user with email "artem.suchov@gmail.com"