Feature: Get Amee Profiles
  In order to gain access to profile information
  As a amee developer
  I want to be able to get amee profiles
  
  Scenario: Get Amee profiles
    Given I have a valid amee session
    When I ask the session for: profiles
    Then there should be an amee profile with the uid of "B28A58B0E243"
    And each amee profile should have a path, name, created, modified and uid
  
  
  

  
