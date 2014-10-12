Feature: User Registragion

  To sign_up in application user goes to sign_up form, which consists only from first and last name, email and password fields and a button.
  After sign_up user is logged in and ready to work with application.

    @javascript
  Scenario: Successfull user sign_up
    Given I am a guest
    When I visit sign up page
    And I fill in the sign up form with valid data
    Then I should be logged in user
    And when I fill in the modal window
    Then I should logged in

  Scenario: User try to sign up with invalid data
    Given I am a guest
    When I visit sign up page
    And I fill in the sign up form with invalid data
    Then I should see the sign_up form again
    And I should not be logged in to application

  Scenario: User Log out
    When I visit sign up page
    And I fill in the sign up form with valid data
    Then I go to sign_out page
    And I should be signed out
