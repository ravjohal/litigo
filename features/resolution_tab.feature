Feature: Resolution tab

  I create a case change the resolution and the changes are saved

  @javascript
  Scenario: I create a case and edit the resolution
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    And I create a case
    And I create the resolution
    Then The resolution for user with email "artem.suchov@gmail.com" should be saved to the db
