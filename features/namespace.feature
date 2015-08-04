Feature: Namespaces functionality

  I add a namespace

  @javascript
  Scenario: I add namespace
    Given PENDING: we need some code change for test cases with using nylas
    Given Confirmed default admin user exists
    And Firm for default user exist
    And I login without firm
    When I add simple namespace

