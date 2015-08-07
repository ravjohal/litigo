Feature: User Registration

  To sign_up in application user goes to sign_up form, which consists only from first and last name, email and password fields and a button.
  After sign_up user is logged in and ready to work with application.

  @javascript
  Scenario: Successful user sign_up
    Given I am a guest
    When I visit sign up page
    And I fill in the sign up form with valid data
    Then I get the confirmation email and confirm it
    And I should be logged in user
    When I fill in the modal window
    Then I should logged in

  @javascript
  Scenario: User try to sign up with invalid data
    Given I am a guest
    When I visit sign up page
    And I fill in the sign up form with invalid data
    Then I should see the sign_up form again

  @javascript
  Scenario: User Log out
    When I visit sign up page
    And I fill in the sign up form with valid data
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    When I fill in the modal window
    And I click to user dropdown
    And I go to sign_out page
    Then I should be signed out

  @javascript
  Scenario: Existed user should be able to send invites to new users
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I to to invite users page
    And I fill invite form with email "andrew@rubyriders.com"
    And I click on "Send Invitations"
    Then I should have message "Invitations were sent to: andrew@rubyriders.com"
    And I make sign out
    And I get the confirmation email and confirm it
    And I fill new invited user form for user with email "andrew@rubyriders.com" and password "password"
    Then I should have message "Your password was set successfully. You are now signed in."
    And I verify invited firm user

  @javascript
  Scenario: Existed user should be able to send invites existed user
    Given Confirmed default admin user exists
    And Firm for default user exist
    And Confirmed user exists with first name "Test", last name "Test", email "andrew@rubyriders.com" and password "password"
    When I login without firm
    And I to to invite users page
    And I fill invite form with email "andrew@rubyriders.com"
    And I click on "Send Invitations"
    Then I should have message "Invitations were sent to: andrew@rubyriders.com"
    And I make sign out
    And I get the confirmation email and confirm it
    And I fill new invited user form for user with email "andrew@rubyriders.com" and password "password"
    Then I should have message "Your password was set successfully. You are now signed in."
    And I verify invited firm user