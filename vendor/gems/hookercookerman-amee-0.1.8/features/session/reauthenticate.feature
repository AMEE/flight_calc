Feature: ReAuthenticate the session
  In order to keep make stale session fresh so we dont lose money from broken calculators
  As a amee developer
  I want to keep my session fresh
  
  Scenario: Keep session fresh
    Given I have a valid amee session
    And the session is stale for path: "/profiles/E0BCB3704D15"
    
    When when I try to get the profile with id: "E0BCB3704D15" the session should be refreshed
    And the amee profile should have: "uid" with: "E0BCB3704D15"
  
  
  

  
