Feature: Check Users functionality

  @javascript
  Scenario: I should be able to invite others user
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I click on "Artem Suchov"
    And I click on "Account Settings"
    And I click on "ADMIN"
    And I fill invite form with email "andrew@rubyriders.com"
    And I click on "Send Invitations"
    Then I should have message "Invitations were sent to: andrew@rubyriders.com"
    And it should be database record for invited user "andrew@rubyriders.com" from "artem.suchov@gmail.com"

  @javascript
  Scenario: I should be able to change invited user role
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Confirmed default invited user for default user
    When I login without firm
    And I click on "Artem Suchov"
    And I click on "Account Settings"
    And I click on "ADMIN"
    And I should have text "Andrew Suchov"
    And I should have text "andrew.suchov@gmail.com"
    And I change invited user role field
    Then I should have message "User updated."
    When I wait for "0.2" seconds
    And user with email "andrew.suchov@gmail.com" should have role "staff"