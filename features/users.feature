Feature: Check Users functionality

  @javascript
  Scenario: I should be able to invite others user
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I go to profile
    And I click on "Manage Users"
    And I wait for "0.4" seconds
    And I fill invite form with email "andrew@rubyriders.com"
    And I click on "Send Invitations"
    Then I should have message "Invitations were sent to: andrew@rubyriders.com"
    And it should be database record for invited user "andrew@rubyriders.com" from "artem.suchov@gmail.com"
    And Invite email should be sended to "andrew@rubyriders.com"

  @javascript
  Scenario: I should be able to change invited user role
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Confirmed default invited user for default user
    When I login without firm
    And I go to profile
    And I click on "Manage Users"
    And I should have text "Andrew Suchov"
    And I should have text "andrew.suchov@gmail.com"
    And I change invited user role field
    Then I should have message "User updated."
    When I wait for "0.2" seconds
    And user with email "andrew.suchov@gmail.com" should have role "staff"

  @javascript
  Scenario: I should be able to delete invited user
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Confirmed default invited user for default user
    When I login without firm
    And I go to profile
    And I click on "Manage Users"
    And I click on "Delete user"
    And I confirm popup
    And I make sign out
    And I fill in the sign in form with second user
    Then I should have message "Invalid email or password."
    When I visit sign up page
    And I am a logged in user with email "andrew.suchov@gmail.com" and password "password"
    And I get the confirmation email and confirm it
    And I should be logged in user with email "andrew.suchov@gmail.com" and password "password"
    And I fill in the modal window
    Then I should logged in


