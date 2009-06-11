Then(/^the profile category should have: \"(.*)\" with: \"(.*)\"$/) do |attribute, value|
  @models["profile_category"].send(attribute).should == value
end

Then(/^the profile category should (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["profile_category"].should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the profile category should not (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["profile_category"].should_not send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the profile category's (\S+) should (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["profile_category"].send(method).should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the profile category's (\S+) should not (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["profile_category"].send(method).should_not send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the profile category's profile_categories: (\S+) should be \"(.*)\"/) do |method ,value|
  @models["profile_category"].item_definition.send(method).should == value
end