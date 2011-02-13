require File.expand_path('../../spec_helper', __FILE__)

describe Plurkr::Client do
  before(:each) do
    @p_client = Plurkr::Client.new(:api_key => test_api_key, :username => test_username,
      :password => test_password)
  end
  
  context "when there are client errors" do
    it "should raise BadRequest with a 400" do
      stub_login_request_invalid
      expect { 
        @p_client.login 
      }.to raise_error(Plurkr::Middleware::BadRequest, "Invalid login")
    end
    
    it "should raise NotFound with a 404 and no message" do
      stub_login_404
      expect { 
        @p_client.login 
      }.to raise_error(Plurkr::Middleware::NotFound)      
    end
  end

  context "when there are server errors" do
    it "should raise InternalServerError on a 500" do
      stub_login_request_500
      expect {
        @p_client.login
      }.to raise_error(Plurkr::Middleware::InternalServerError)
    end
  end

=begin TODO: How do I do this?
  context "when invalid json is returned" do
    it "should raise an UnintelligibleResponse error" do
      stub_login_html
      expect { 
        @p_client.login 
      }.to raise_error(Plurkr::Middleware::UnintelligibleResponse)        
    end
  end
=end

end