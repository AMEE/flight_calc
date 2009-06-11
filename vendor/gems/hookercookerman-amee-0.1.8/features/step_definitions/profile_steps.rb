When(/^I create an amee profile$/) do
  FakeWeb.register_uri(:post, "http://stage.amee.com/profiles?profile=true", 
    :file => File.join(AMEE_FIXTURE_PATH, "profiles/profile.json")
   )
  @models["profile"] = @amee_session.create_profile
end

Then(/^I should have a valid amee profile$/) do
  @models["profile"].name.should == "180D73DA5229"
  @models["profile"].uid.should == "180D73DA5229"
end

Then(/^I delete that amme profile$/) do
  FakeWeb.register_uri(:delete, "http://stage.amee.com/profiles/#{@models["profile"].uid}", 
    {:status => [200, "OK"]}
   )
  @models["profile"].destroy
end

Then(/^the profile should no longer exist$/) do
  FakeWeb.register_uri(:get, "http://stage.amee.com/profiles/#{@models["profile"].uid}", 
    {:status => ["404", "Not Found"]}
   )
  lambda{@amee_session.get_profile(@models["profile"].uid)}.should raise_error(Amee::Session::NotFound)  
end

Then(/^the amee profile should have: \"(.*)\" with: \"(.*)\"$/) do |attribute, value|
  @models["profile"].send(attribute).should == value
end

Then(/^the amee profile should (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["profile"].should send("be_#{predicate.gsub(' ', '_')}")
end

Then(/^the amee profile data_category's: (\S+) should be \"(.*)\"/) do |method ,value|
  @models["profile"].profile_data_categories.send(method).should == value
end

Then(/^the amee profile profile_categories should not (?:be|have) (?:an? )?(.*)/) do |predicate|
  @models["profile"].profile_categories.should_not send("be_#{predicate.gsub(' ', '_')}")
end