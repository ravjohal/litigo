Feature: Dashboard
  I sign in and visit dashboard.

  @javascript
  Scenario: I should be able to create: Lead, Case, Contact Task, Document and Note from dashboard.
    Given there is a user with the email "andrew@rubyriders.com", the first_name "Andrew", the last_name "Goncharenko" and the password "password" and the confirmed_at "2014-11-12 11:52:41.207207"
    When I log in with email "andrew@rubyriders.com" and password "password"
    And when I fill in the modal window
    Then I see dashboard with creation quick-links
    When I click "New Client Intake"
    And I fill Client Intake modal
    Then lead should be created
    Then I return to dashboard
    When I click "New Case"
    And I fill Case modal
    Then case should be created
