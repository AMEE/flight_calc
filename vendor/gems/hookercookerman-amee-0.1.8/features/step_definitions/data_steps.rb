# AMEE DATA CATEGORY
When(/^I ask the session for: get_data_category with path: \"(.*)\"$/) do |path|
  FakeWeb.register_uri(:get, "http://stage.amee.com#{path}", 
    :file => File.join(AMEE_FIXTURE_PATH, "#{path.gsub(/^\//, "")}.json")
   )
  @models["data_category"] = @amee_session.get_data_category(path)
end

When(/^I ask the data category for its: \"(\S+)\"$/) do |method|
   @models[method] = @models["data_category"].send(method)
end

Then(/^the data category should have: \"(.*)\" with: \"(.*)\"$/) do |attribute, value|
  @models["data_category"].send(attribute).should == value
end

Then(/^the data category should (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["data_category"].should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data category should not (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["data_category"].should_not send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data category's (.*) should (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["data_category"].send(method).should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data category's (.*) should not (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["data_category"].send(method).should_not send("be_#{predicate.gsub(' ', '_')}")
end

# AMEE DATA ITEM YES COULD REFACTOR
When(/^I ask the session for: get_data_item with path: \"(.*)\"$/) do |path|
  FakeWeb.register_uri(:get, "http://stage.amee.com#{path}", 
    :file => File.join(AMEE_FIXTURE_PATH, "#{path.gsub(/^\//, "")}.json")
   )
  @models["data_item"] = @amee_session.get_data_item(path)
end

When(/^I ask the data item for its: \"(\S+)\"$/) do |method|
   @models[method] = @models["data_item"].send(method)
end

Then(/^the data item should have: \"(.*)\" with: \"(.*)\"$/) do |attribute, value|
  @models["data_item"].send(attribute).should == value
end

Then(/^the data item should (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["data_item"].should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data item should not (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["data_item"].should_not send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data item's (\S+) should (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["data_item"].send(method).should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data item's (\S+) should not (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["data_item"].send(method).should_not send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data item's item_definition: (\S+) should be \"(.*)\"/) do |method ,value|
  @models["data_item"].item_definition.send(method).should == value
end


# YES COULD REFACTOR DATA ITEM VALUE
# AMEE DATA ITEM YES COULD REFACTOR
When(/^I ask the session for: get_data_item_value with path: \"(.*)\"$/) do |path|
  FakeWeb.register_uri(:get, "http://stage.amee.com#{path}", 
    :file => File.join(AMEE_FIXTURE_PATH, "#{path.gsub(/^\//, "")}.json")
   )
  @models["data_item_value"] = @amee_session.get_data_item_value(path)
end

When(/^I ask the data item value for its: \"(\S+)\"$/) do |method|
   @models[method] = @models["data_item_value"].send(method)
end

Then(/^the data item value should have: \"(.*)\" with: \"(.*)\"$/) do |attribute, value|
  @models["data_item_value"].send(attribute).should == value
end

Then(/^the data item value should (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["data_item_value"].should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data item value should not (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["data_item_value"].should_not send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data item value's (\S+) should (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["data_item_value"].send(method).should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data item value's (\S+) should not (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["data_item_value"].send(method).should_not send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the data item value's item_value_definition: (\S+) should be \"(.*)\"/) do |method ,value|
  @models["data_item_value"].item_value_definition.send(method).should == value
end

# DRILL DOWNS
Given(/I drill down with params: \"(.*)\"/) do |params|
  FakeWeb.register_uri(:get, "http://stage.amee.com#{@models["data_category"].full_path}/drill#{params}", 
    :file => File.join(AMEE_FIXTURE_PATH, "#{@models["data_category"].full_path.gsub(/^\//, "")}/drill#{params}.json")
   )
  # what a wicked line hmmmm
  input = params.gsub("?", "").split("&").map{|a| a.split("=")}.flatten
  selection = Hash[*input.flatten]

  @models["drill_down"] = @models["data_category"].drill(selection)
end


Then(/^the drill down should have: \"(.*)\" with: \"(.*)\"$/) do |attribute, value|
  @models["drill_down"].send(attribute).should == value
end

Then(/^the drill down should (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["drill_down"].should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the drill down should not (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["drill_down"].should_not send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the drill down's (\S+) should (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["drill_down"].send(method).should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the drill down's (\S+) should not (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["drill_down"].send(method).should_not send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the drill down data category's should have: \"(\S+)\" with: \"(\S+)\"/) do |method, value|
  @models["drill_down"].data_category.send(method).should == value
end