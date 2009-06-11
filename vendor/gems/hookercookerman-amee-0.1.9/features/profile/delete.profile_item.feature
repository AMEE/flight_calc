Feature: Deleting a Profile Item
  In order to make sure we can delete stale profile items
  As a amee developer
  I want to be able to delete a profile item
  
  Scenario: Delete an amee profile
    Given I have a valid amee session
    And I profile exists with path "/profiles/155DD3C63646/transport/motorcycle/generic/D47C465B8157"
    
    When I delete the profile item
    
    Then the profile item should no longer exist
  
