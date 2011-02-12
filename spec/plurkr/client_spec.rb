require File.expand_path('../../spec_helper', __FILE__)

describe Plurkr::Client do
  
  before(:each) do
    @p_client = Plurkr::Client.new(:api_key => test_api_key, :username => test_username,
      :password => test_password)
  end  
  
  context "when configuring" do
    it "should be configurable through initializer" do
      @p_client.api_key.should eq(test_api_key)
      @p_client.username.should eq(test_username)
      @p_client.password.should eq(test_password)
    end
  
    it "should be resetable" do
      @p_client.reset
      @p_client.api_key.should be_nil
      @p_client.username.should be_nil
      @p_client.password.should be_nil
    end
  end
  
  context "when making requests" do
    it "should require authentication when requesting a resource" do
      expect { 
        @p_client.request_resource(:resource => 'Polling/getUnreadCount') 
      }.to raise_error(Plurkr::Unauthenticated)
    end
    
    it "should not require authentication when told otherwise" do
      stub_logout_request
      @p_client.request_resource(:resource => 'Users/logout', :no_auth => true)
    end
    
    it "should create session after logging in" do
      stub_login_request
      @p_client.request_authentication(:username => test_username, :password => test_password)
      @p_client.authenticated?().should be_true
    end
  end
end