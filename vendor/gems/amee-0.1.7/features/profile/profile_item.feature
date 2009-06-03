Feature: Getting Amee Profile Item
  In order to gain access to profile item information which means we can keep
  In order co2 histroy and calcuations and profit big time
  As a amee developer
  I want to be able to get profile items
  
  Scenario: Get Amee profile item with path /profiles/F38ECBD56D59/home/energy/quantity/5891C88F29FA 
    Given I have a valid amee session
    When I ask the session for: get_profile_item with path: "/profiles/F38ECBD56D59/home/energy/quantity/5891C88F29FA"
    
    Then the profile item should have: "co2_value" with: "24.66"
    And the profile item should have: "co2_unit" with: "kg/year"
    And the profile item should have: "resource_path" with: "/home/energy/quantity/5891C88F29FA"
    And the profile item should have: "start_date" with: "Thu Mar 19 16:51:00 UTC 2009"
    And the profile item should have: "end_date" with: ""
    And the profile item's item_values should not be nil
    And the profile item's item_definition should not be nil