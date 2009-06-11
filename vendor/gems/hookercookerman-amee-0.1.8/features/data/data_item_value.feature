Feature: Get Amee DataItemValue
  In order to gain access to data_item_value information so I can make loads of money from making
  In order carbon calculators
  As a amee developer
  I want to be able to get amee data item value
  
  
  Scenario: Get Amee Date Item with path /data/transport/plane/generic/FFC7A05D54AD/kgCO2PerPassengerJourney
    Given I have a valid amee session
    When I ask the session for: get_data_item_value with path: "/data/transport/plane/generic/FFC7A05D54AD/kgCO2PerPassengerJourney"
    
    Then the data item value should have: "path" with: "kgCO2PerPassengerJourney"
    And the data item value should have: "name" with: "kgCO2 Per Passenger Journey"
    And the data item value should have: "uid" with: "C32B6E2EDCB0"
    
    And the data item value's item_value_definition: uid should be "653828811D42" 
    And the data item value's item_value_definition: name should be "kgCO2 Per Passenger Journey"
