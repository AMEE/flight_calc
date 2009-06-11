Then(/^the profile item should have: \"(.*)\" with: \"(.*)\"$/) do |attribute, value|
  @models["profile_item"].send(attribute).to_s.should == value
end

Then(/^the profile item should (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["profile_item"].should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the profile item should not (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["profile_item"].should_not send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the profile item's (\S+) should (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["profile_item"].send(method).should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the profile item's (\S+) should not (?:be|have) (?:an? )?(.*)/) do |method, predicate|
  @models["profile_item"].send(method).should_not send("be_#{predicate.gsub(' ', '_')}")
end

When(/^I create a profile item with uid: \"(\S+)\" the path: \"(.*)\"/) do |uid, path|
  FakeWeb.register_uri(:post, "http://stage.amee.com#{path}?type=dontmatter&dataItemUid=48B97680BEGG&representation=full",
  :file => File.join(AMEE_FIXTURE_PATH, "/profiles/155DD3C63646/transport/motorcycle/generic/D47C465B8157.json")
   )
  @models["profile_item"] = @amee_session.create_profile_item(path, uid, :fields => {:type => "dontmatter"})
end

When(/^I update the profile item with: distance=400$/) do
  FakeWeb.register_uri(:put, "http://stage.amee.com#{@models["profile_item"].full_path}?distance=400&representation=true",
    :file => File.join(AMEE_FIXTURE_PATH, "#{@models["profile_item"].full_path.gsub(/^\//, "")}?distance=400&representation=true.json")
   )
  @models["profile_item"].update(:distance => 400)
end

Then(/^the profile item item_value: with name: \"Distance\" should have value: \"400\"$/) do
  @models["profile_item"].item_values.find{ |item_value| item_value.name == "Distance"}.value.should == "400"
end

Given(/I profile exists with path \"(\S+)\"/) do |path|
  FakeWeb.register_uri(:get, "http://stage.amee.com#{path}",
  :file => File.join(AMEE_FIXTURE_PATH, "#{path.gsub(/^\//, "")}.json")
   )
   @models["profile_item"] = @amee_session.get_profile_item(path)
end

When(/^I delete the profile item$/) do
  FakeWeb.register_uri(:delete, "http://stage.amee.com#{@models["profile_item"].full_path}", 
    {:status => [200, "OK"]}
   )
  @models["profile_item"].destroy
end

Then(/^the profile item should no longer exist$/) do
  FakeWeb.register_uri(:get, "http://stage.amee.com#{@models["profile_item"].full_path}", 
    {:status => ["404", "Not Found"]}
   )
  lambda{@amee_session.get_profile_item(@models["profile_item"].full_path)}.should raise_error(Amee::Session::NotFound)
end
