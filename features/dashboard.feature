Feature: Dashboard
  I sign in and visit dashboard.

  @javascript
  Scenario: I should be able to create: Lead, Case, Contact Task, Document and Note from dashboard.
    Given Confirmed default admin user exists
    When I login
    Then I see dashboard with creation quick-links
#    When I click "New Caller Intake"
#    And I fill Client Intake modal
#    Then lead should be created
#    Then I return to dashboard
    When I click "New Case"
    And I fill Case modal
    Then case should be created
