require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Given we have setup the fake requests" do
  before(:each) do
    # Auth fake me requester
    Amee::Service.stub!(:auth_token).and_return("random auth token")
  end
  
  describe "Amee::Session.create", "given the config has a username and password" do
    before(:each) do
      Amee::Config.set do |config|
        config[:username] =  "eat junk"
        config[:password] = "become junk"
      end
    end
  
    it "should use the username and password from the config" do
      @amee_session = Amee::Session.create
      @amee_session.instance_variable_get("@username").should == "eat junk"
      @amee_session.instance_variable_get("@password").should == "become junk"
      @amee_session.auth_token.should == "random auth token"
    end
    
    it "should try to authenticate the session when creating it" do
      Amee::Service.should_receive(:auth_token)
      Amee::Session.create
    end
    
    it "should have a default cache of Moneta::Memory" do
      @amee_session = Amee::Session.create("whatver", "da")
      @amee_session.cache.should be_a(Moneta::Memory)
    end
  end
  
  describe "Amee::Session", "#store_resource" do
    before(:each) do
      @amee_session = Amee::Session.create("myname", "mypassword")
    end
    
    it "should try to use default cache expires_in if none given" do
      @amee_session.cache.should_receive(:store).with("/path", "result", {:expires_in=>86400})
      @amee_session.store_resource("/path", "result")
    end
  end
end