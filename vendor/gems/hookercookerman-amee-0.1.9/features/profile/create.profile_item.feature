Feature: Create Amee Profile Item
  In order to add co2 data that then can be used to calculate cos2 emission
  As a amee developer
  I want to be able to be albe to create profile data items
  
  Scenario: Create Amee profile item with path /profiles/48B97680BCCF/home/energy/quantity
    Given I have a valid amee session
    
    # representation=full&energyConsumption=10&energyConsumptionUnit=kWh&dataItemUid=66056991EE23&energyConsumptionPerUnit=month&name=representation
    When I create a profile item with data_item_uid: "66056991EE23" the path: "/profiles/BB1BDB4FDD77/home/energy/quantity"
    
    # need to redo
    Then the profile category should have: "total_co2_value" with: "24.660000"
    And the profile category should have: "resource_path" with: "/home/energy/quantity"
    And the profile category's profile_items should not be empty
    And the profile category's profile_categories should be empty
    And the profile category's data_category should not be nil
