Feature: Get Amee Profile Category
  In order to gain access to profile data category information
  As a amee developer
  I want to be able to get profile data categories
  
  Scenario: Get Amee profile category with path /profiles/180D73DA5229/Home
    Given I have a valid amee session
    When I ask the session for: get_profile_category with path: "/profiles/180D73DA5229/home"
    
    Then the profile category should have: "total_amount" with: "0"
    And the profile category should have: "resource_path" with: "/home"
    And the profile category's profile_items should be empty
    And the profile category's profile_categories should not be empty
    And the profile category's data_category should not be nil