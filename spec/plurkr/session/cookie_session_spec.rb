require File.expand_path('../../../spec_helper', __FILE__)

describe Plurkr::Session::CookieSession do

  before(:each) do
    @p_client = Plurkr::Client.new(:api_key => test_api_key, :username => test_username,
      :password => test_password)
  end
 
  context "when logging in" do
    it "should create a session" do
      stub_login_request
      c = Plurkr::Session::CookieSession.new(@p_client)
      c.login
      c.authenticated?().should be_true
    end
    
    it "should require a username and password" do
      c = Plurkr::Session::CookieSession.new(Plurkr::Client.new(:api_key => test_api_key))
      expect {c.login}.to raise_error(Plurkr::Session::SessionCreationCredentialsNotSupplied)
    end
  end
  
  context "when logged in" do
    it "should make authenticated requests" do
      stub_login_request
      stub_dev_null
      c = Plurkr::Session::CookieSession.new(@p_client)
      c.login
      response = c.authenticated_request( :method => :get, :resource => "Dev/null" )
      response_success_text(response).should eq( a_successful_response )
    end
    
    it "should create a session automatically" do
      stub_login_request
      stub_dev_null
      c = Plurkr::Session::CookieSession.new(@p_client)
      response = c.authenticated_request( :method => :get, :resource => "Dev/null" )
      response_success_text(response).should eq( a_successful_response )
    end
    
    it "should fail if a session cannot be established" do
      stub_login_request
      stub_dev_null_login_required
      c = Plurkr::Session::CookieSession.new(@p_client)
      expect {
        c.authenticated_request( :method => :get, :resource => "Dev/null" )
      }.to raise_error(Plurkr::Middleware::LoginRequired)     
    end
  end
  
  context "when logging out" do
    it "should destroy the current session" do
      stub_login_request
      stub_logout_request
      c = Plurkr::Session::CookieSession.new(@p_client)
      c.login
      c.authenticated?().should be_true
      c.logout.should be_true
      c.authenticated?().should be_false     
    end
    it "should return false if no session exists" do
      Plurkr::Session::CookieSession.new(@p_client).logout.should be_false
    end
  end
end