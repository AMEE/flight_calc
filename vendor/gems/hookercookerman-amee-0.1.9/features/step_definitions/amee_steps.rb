# AMEE SESSION
Given(/^I have a valid amee session$/) do
  @models ||= {}
  Amee::Service.stub!(:auth_token).and_return("random auth token")
  @amee_session = Amee::Session.create("datest", "datest")
end


# Profiles
When(/^I ask the session for: profiles$/) do
  FakeWeb.register_uri(:get, "http://stage.amee.com/profiles", 
    :string => "#{File.read(File.join(AMEE_FIXTURE_PATH, "profiles.json"))}"
   )
  @models["profiles"] = @amee_session.profiles
end

# Profile
When(/^I ask the session for: profile with: \"(\S+)\"/) do |param|
  FakeWeb.register_uri(:get, "http://stage.amee.com/profiles/#{param}", 
    :file => File.join(AMEE_FIXTURE_PATH, "profiles/#{param}.json")
   )
  @models["profile"] = @amee_session.get_profile(param)
end

# Profile Category
When(/^I ask the session for: get_profile_category with path: \"(\S+)\"$/) do |path|
  FakeWeb.register_uri(:get, "http://stage.amee.com#{path}", 
    :file => File.join(AMEE_FIXTURE_PATH, "#{path.gsub(/^\//, "")}.json")
   )
  @models["profile_category"] = @amee_session.get_profile_category(path)
end

# PROFILE ITEM
# Profile Category
When(/^I ask the session for: get_profile_item with path: \"(\S+)\"$/) do |path|
  FakeWeb.register_uri(:get, "http://stage.amee.com#{path}", 
    :file => File.join(AMEE_FIXTURE_PATH, "#{path.gsub(/^\//, "")}.json")
   )
  @models["profile_item"] = @amee_session.get_profile_item(path)
end


Then(/^there should be an amee profile with the uid of \"(\S+)\"$/) do |uid|
  @models["profiles"].map{|profile| profile.uid}.should include(uid)
end

Then(/^each amee profile should have a path, name, created, modified and uid$/) do
  @models["profiles"].each do |profile|
    profile.path.should_not be_nil
    profile.name.should_not be_nil
    profile.uid.should_not be_nil
    profile.created.should_not be_nil
    profile.modified.should_not be_nil
  end
end

Given(/^the session is stale for path: \"(\S+)\"$/) do |path|
  FakeWeb.register_uri(:get, "http://stage.amee.com#{path}", 
    [{:status => ["401", "NOT COOL"]},
     {:file => File.join(AMEE_FIXTURE_PATH, "#{path.gsub(/^\//, "")}.json")}
    ])
end

When(/^when I try to get the profile with id: \"(\S+)\" the session should be refreshed/) do |id|
  @amess_sessino.should_receive(:authenticate!)
  @models["profile"] = @amee_session.get_profile(id)
end
