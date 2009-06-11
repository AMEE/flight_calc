Feature: Get Amee Profiles
  In order to gain access to profile information
  As a amee developer
  I want to be able to get an amee profile
  
  Scenario: Get Amee profile
    Given I have a valid amee session
    When I ask the session for: profile with: "E0BCB3704D15"
    
    Then the amee profile should have: "uid" with: "E0BCB3704D15"
    And the amee profile should have: "name" with: "E0BCB3704D15"
    And the amee profile should have: "path" with: "E0BCB3704D15"
    And the amee profile should have: "total_amount" with: "10"
    And the amee profile profile_categories should not be empty