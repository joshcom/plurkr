require File.expand_path('../../spec_helper', __FILE__)

describe Plurkr::Client do
  before(:each) do
    @p_client = Plurkr::Client.new(:api_key => test_api_key, :username => test_username,
      :password => test_password)
  end
  
  context "when configuring" do
    it "should be resetable" do
      @p_client.reset
      @p_client.api_key.should be_nil
      @p_client.username.should be_nil
      @p_client.password.should be_nil
    end
    
    it "should return a configuration hash" do
      @p_client.configuration[:username].should eq(test_username)
    end
  end
end