Feature: Get Amee DataItem
  In order to gain access to data_item information so I can make loads of money from making
  In order carbon calculators
  As a amee developer
  I want to be able to get amee data items
  
  
  Scenario: Get Amee Date Item with path /data/transport/car/generic/E57D6E2828EB
    Given I have a valid amee session
    When I ask the session for: get_data_item with path: "/data/transport/car/generic/E57D6E2828EB"
    
    Then the data item should have: "path" with: ""
    And the data item should have: "name" with: "E57D6E2828EB"
    And the data item should have: "uid" with: "E57D6E2828EB"
    And the data item's item_values should not be nil
    And the data item's choices should not be nil
    
    And the data item's item_definition: drill_down should be "fuel, size"
    And the data item's item_definition: name should be "Car Generic"