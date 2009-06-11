Feature: Get Amee Drill Down
  In order to gain the correct access to a data item
  As a amee developer
  I want to be able to get amee drill down
  
  Scenario: get a drill down for data_category with path /data/transport/car/generic
    Given I have a valid amee session
    
    When I ask the session for: get_data_category with path: "/data/transport/car/generic"
    And I drill down with params: ""
    
    Then the drill down should have: "choice_name" with: "fuel"
    And the drill down's choices should not be empty
    And the drill down's selections should be empty
    And the drill down data category's should have: "uid" with: "87E55DA88017"
    And the drill down data category's should have: "name" with: "Generic"
    And the drill down data category's should have: "path" with: "generic"
    
  Scenario: get a drill down for data_category with path /data/transport/car/generic
    Given I have a valid amee session

    When I ask the session for: get_data_category with path: "/data/transport/car/generic"
    And I drill down with params: "?fuel=diesel"

    Then the drill down should have: "choice_name" with: "size"
    And the drill down's choices should not be empty
    And the drill down's selections should not be empty
    And the drill down data category's should have: "uid" with: "87E55DA88017"
    And the drill down data category's should have: "name" with: "Generic"
    And the drill down data category's should have: "path" with: "generic"

  Scenario: get a drill down for data_category with path /data/transport/car/generic
    Given I have a valid amee session

    When I ask the session for: get_data_category with path: "/data/transport/car/generic"
    And I drill down with params: "?fuel=diesel&size=large"

    Then the drill down should have: "choice_name" with: "uid"
    And the drill down should have: "data_item_uid" with: "4F6CBCEE95F7"
    And the drill down should be uid_found
    And the drill down's choices should not be empty
    And the drill down's selections should not be empty
    And the drill down data category's should have: "uid" with: "87E55DA88017"
    And the drill down data category's should have: "name" with: "Generic"
    And the drill down data category's should have: "path" with: "generic"

    
    