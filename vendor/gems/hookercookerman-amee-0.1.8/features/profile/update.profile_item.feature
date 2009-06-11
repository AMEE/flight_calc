Feature: Update Amee Profile Item
  In order to update profile item information which means we can keep
  In order co2 histroy and calcuations and profit big time
  As a amee developer
  I want to be able to update a profile items
  
  Scenario: Update Amee profile item with path /profiles/155DD3C63646/transport/motorcycle/generic/D47C465B8157
    Given I have a valid amee session
    When I ask the session for: get_profile_item with path: "/profiles/155DD3C63646/transport/motorcycle/generic/D47C465B8157"
    
    
    And I update the profile item with: distance=400
    
    Then the profile item item_value: with name: "Distance" should have value: "400"