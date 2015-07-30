Feature: Document tab

  I create a case change the document and the changes are saved

  @javascript
  Scenario: I create a case and edit the document
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create a case
    And I create the document
    Then The document for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: I create a case and create the document with file uploading
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create a case
    And I create the document with file upload
    Then I should have text "Document was successfully created."
    Then The document with file for user with email "artem.suchov@gmail.com" should be saved to the db

  @javascript
  Scenario: Create a Document (not case tabs)
    Given Confirmed default admin user exists
    And Firm for default user exist
    When I login without firm
    And I create the document through case management
    Then The document for user with email "artem.suchov@gmail.com" should be saved to the db with the right fields
