require File.expand_path('../../spec_helper', __FILE__)

describe Plurkr do
  context "when configuring" do
    it "should be configurable in a block" do
      Plurkr.configure do |c|
        c.api_key = test_api_key
        c.username = test_username
        c.password = test_password
      end
      
      Plurkr.api_key.should eq(test_api_key)
    end
  end
end

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