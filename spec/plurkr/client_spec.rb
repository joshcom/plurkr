require File.expand_path('../../spec_helper', __FILE__)

describe Plurkr::Client do
  
  before(:each) do
    @p_client = Plurkr::Client.new(:api_key => test_api_key, :username => test_username,
      :password => test_password)
  end  
  
  context "when initializing" do
    it "should be configurable through initializer" do
      @p_client.api_key.should eq(test_api_key)
      @p_client.username.should eq(test_username)
      @p_client.password.should eq(test_password)
    end
  end
  
  context "when making requests" do
    it "should request without error" do
      stub_logout_request
      @p_client.request(:resource => 'Users/logout')
    end

  end
end