Feature: Deleting a Profile
  In order to make sure we can delete stale data
  As a amee developer
  I want to be able to delete a profile
  
  Scenario: Delete an amee profile
    Given I have a valid amee session
    When I create an amee profile
    When I delete that amme profile
    
    Then the profile should no longer exist
  
