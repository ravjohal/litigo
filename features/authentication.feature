Feature: User Registragion

  To sign_up in application user goes to sign_up form, which consists only from first and last name, email and password fields and a button.
  After sign_up user is logged in and ready to work with application.

  Scenario: Successfull user sign_up
    Given I am a guest
    When I visit sign up page
    And I fill in the sign_up form with email "such@gmail.com" password "password"
    Then "Anonymous" should appear on the edit page
    And I should receive welcome email