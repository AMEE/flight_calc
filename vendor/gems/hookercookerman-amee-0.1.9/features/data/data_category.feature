Feature: Get Amee Category
  In order to gain access to data information
  As a amee developer
  I want to be able to get amee categories
  
  Scenario: Get Amee category with path /data
    Given I have a valid amee session
    When I ask the session for: get_data_category with path: "/data"
    
    Then the data category should have: "path" with: ""
    And the data category should have: "name" with: "Root"
    And the data category should have: "uid" with: "CD310BEBAC52"
    And the data category's data_items should be empty
    And the data category's data_categories should not be empty
    
  Scenario: Get Amee category with path /data/transport/plane/generic
    Given I have a valid amee session
    When I ask the session for: get_data_category with path: "/data/transport/plane/generic"

    Then the data category should have: "path" with: "generic"
    And the data category should have: "resource_path" with: "/transport/plane/generic"
    And the data category should have: "name" with: "Generic"
    And the data category should have: "uid" with: "FBA97B70DBDF"
    
    And the data category's data_items should not be empty
    And the data category's data_categories should not be empty