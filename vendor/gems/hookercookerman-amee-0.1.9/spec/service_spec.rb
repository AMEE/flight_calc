require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


describe "Given FakeRequests Are Setup" do
  before(:each) do
    
    FakeWeb.register_uri(:get, "http://stage.amee.com/path", 
      {:string => "{}", :status => [200, "OK"]})
  end
  
  describe "Service", "when performing a request" do

    before(:each) do
      @service = Amee::Service.new("whatever token")
    end
    
    it "should send a request with headers of AuthToken And Accept" do
      Amee::Service.should_receive(:get).
        with("/path", {:headers => {"authToken" => "whatever token", "Accept" => Amee::Config[:accept]}}).
        and_return(mock("response",:code => 200))
      @service.get("raw", "/path")
    end
    
    it "should parse the response" do
      Amee::Parser.should_receive(:parse).with("raw", {})
      @service.get("raw", "/path")
    end
    
    it "should raise Amee::Session::PermissionDenied if status code is 403" do
      FakeWeb.register_uri(:get, "http://stage.amee.com/path", 
        {:string => "{}", :status => [403, "Permission denied"]})
      lambda{@service.get("raw", "/path")}.should raise_error(Amee::Session::PermissionDenied )
    end
    
    it "should raise Amee::Session::Expired if status code is 401" do
      FakeWeb.register_uri(:get, "http://stage.amee.com/path", 
        {:string => "{}", :status => [401, "Permission denied"]})
      lambda{@service.get("raw", "/path")}.should raise_error(Amee::Session::Expired )
    end
    
    it "should raise Amee::Session::UnknownError if status code is 609" do
      FakeWeb.register_uri(:get, "http://stage.amee.com/path", 
        {:string => "{}", :status => [609, "Permission denied"]})
      lambda{@service.get("raw", "/path")}.should raise_error(Amee::Session::UnknownError )
    end
    
    it "should raise Amee::NotFound::Expired if status code is 404" do
      FakeWeb.register_uri(:get, "http://stage.amee.com/path", 
        {:string => "{}", :status => [404, "Permission denied"]})
      lambda{@service.get("raw", "/path")}.should raise_error(Amee::Session::NotFound )
    end
  end
end
