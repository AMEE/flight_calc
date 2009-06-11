Feature: Create Amee Profile Item
  In order to add co2 data that then can be used to calculate cos2 emission
  As a amee developer
  I want to be able to be albe to create profile data items
  
  Scenario: Create Amee profile item with path /profiles/48B97680BCCF/home/energy/quantity
    Given I have a valid amee session
    
    # representation=full&energyConsumption=10&energyConsumptionUnit=kWh&dataItemUid=66056991EE23&energyConsumptionPerUnit=month&name=representation
    When I create a profile item with uid: "48B97680BEGG" the path: "/profiles/48B97680BCCF/home/energy/quantity"
    
    # need to redo
    Then the profile item should have: "uid" with: "D47C465B8157"
