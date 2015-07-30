Feature: Medical tab

  I create a case change the medical and the changes are saved

  @javascript
  Scenario: I create a case and create the medical
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    When I fill in the modal window
    And I should logged in
    And I create a case
    And I create the medical
    Then The medical for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I add edit the injury of the medical tab
    When I visit sign up page
    Given I am a logged in user with email "artem.suchov@gmail.com" and password "password"
    Then I get the confirmation email and confirm it
    Then I should be logged in user
    When I fill in the modal window
    And I should logged in
    And I create a case
    And I create the injury
    Then The injury for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I change case medicals
    Given Confirmed default user exists
    And Firm for default user exist
    And Default medical case exist
    When I login without firm
    And I click on "Case Management"
    And I go to first firm case
    And I click to tab "MEDICALS"
    And I wait for "0.3" seconds
    And I click on "Edit"
    And I fill case medicals form
    And I add bill row to medicals form with "12345", "2000", "320"
    And I add bill row to medicals form with "12345789", "1500", "100"
    And I click on "Save"
    Then I should have message "Medical was successfully updated."
    And case medical should be updated
    When I click on "ADD INJURY"
    And I fill injury form
    And I click on "Create Injury"
    Then I should have message "Injury was successfully created."
    And I verify medical injury count should be 1
    And I verify created injury
    When I click to element with id "delete"
    And I confirm popup
    Then I should have message "Injury was successfully destroyed."
    And I verify medical injury count should be 0