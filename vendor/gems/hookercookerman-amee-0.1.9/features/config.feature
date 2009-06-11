Feature: Amee can be configured

  As a ruby developer
  I want to set an Amee config 
  So that so Amee can run under a certain configurations
  
  Scenario: defaults should be available if no config has been set
    When I do not create a config
    
    Then the amee config: "server" should be: "stage.amee.com"
    And the amee config: "cache_store" should be: "Moneta::Memory"
    And the amee config: "cache" should be: "true"
    
  Scenario: server should be changed if I set a config with new server
    When I set the: "logging" on the amee config with: "false"

    Then the amee config: "logging" should be: "false"
    And the amee config: "cache_store" should be: "Moneta::Memory"
    And the amee config: "cache" should be: "true"
  
  
  
