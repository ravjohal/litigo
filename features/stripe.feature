Feature: Stripe functionality

  I visit Billing Information and I see the sing up suggestion

  @javascript
  Scenario: I subscribe to new subscription plan
    Given I have some plans
    And Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I subscribe to subscription plan with email "artem.suchov@gmail.com" with valid data
    And I wait for "15" seconds
    Then The subscription for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I subscribe to new subscription plan with invalid data
    Given I have some plans
    And Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I subscribe to subscription plan with email "artem.suchov@gmail.com" with invalid card number
    And I wait for "15" seconds
    Then The subscription for user with email "artem.suchov@gmail.com" should not be saved to the db

  @javascript
  Scenario: I update card info
    Given I have some plans
    And Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I subscribe to subscription plan with email "artem.suchov@gmail.com" with valid data
    And I wait for "15" seconds
    And I update card info with email "artem.suchov@gmail.com" with valid data
    And I wait for "15" seconds
    Then The subscription for user with email "artem.suchov@gmail.com" should be updated to the db

  @javascript
  Scenario: I change subscription plan
    Given I have some plans
    And Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I subscribe to subscription plan with email "artem.suchov@gmail.com" with valid data
    And I wait for "15" seconds
    And I change subscription plan
    And I wait for "15" seconds
    Then The subscription plan for user with email "artem.suchov@gmail.com" should be changed

  @javascript
  Scenario: I cancel subscription plan
    Given I have some plans
    And Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I subscribe to subscription plan with email "artem.suchov@gmail.com" with valid data
    And I wait for "15" seconds
    And I cancel subscription plan
    And I wait for "15" seconds
    Then The subscription plan for user with email "artem.suchov@gmail.com" should be canceled