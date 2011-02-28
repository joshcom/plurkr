require File.expand_path('../../lib/plurkr',__FILE__)
require 'rspec'
require 'webmock/rspec'
  
RSpec.configure do |config|
  config.include WebMock::API
end

def test_api_key
  "APIKEY1234"
end

def test_username
  "joshua"
end

def test_password
  "password"
end

def configure_client
  stub_login_request
  Plurkr.configure do |p|
    p.api_key = test_api_key
    p.username = test_username
    p.password = test_password
  end
end

def response_success_text(response)
  response.body["success_text"]
end

def a_successful_response
  "ok"
end

def fixture(file)
  File.new( File.expand_path('../fixtures', __FILE__) + "/" + file)
end

def base_stub_login
  stub_request(:get, "https://www.plurk.com/API/Users/login?api_key=#{test_api_key}&no_data=1&password=#{test_password}&username=#{test_username}").
    with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
end

def stub_login_html
  base_stub_login.to_return(:status => 200, :body => "<html><head></head><body><h1>You're in!</h1></body></html>", :headers => {
      "set-cookie" => "my cookie"
    })  
end

def stub_login_404
  base_stub_login.to_return(:status => 404, :body => fixture("login.json"), :headers => {})
end

def stub_login_request_invalid
  base_stub_login.to_return(:status => 400, :body => fixture("login_400_invalid.json"), :headers => {})
end

def stub_login_request_too_many_logins
  base_stub_login.to_return(:status => 400, :body => fixture("login_400_too_many.json"), :headers => {})
end

def stub_login_request_500
  base_stub_login.to_return(:status => 500, :body => "{}", :headers => {})
end

def stub_login_request_login_required
  base_stub_login.to_return(:status => 400, :body => fixture("login_400_login_required.json"), :headers => {})
end

def stub_login_request
  base_stub_login.to_return(:status => 200, :body => fixture("login.json"), :headers => {
      "set-cookie" => "my cookie"
    })
end

def stub_logout_request
  stub_request(:get, "http://www.plurk.com/API/Users/logout?api_key=#{test_api_key}").
    with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => fixture("logout.json"), :headers => {})
end

def stub_dev_null
  stub_request(:get, "http://www.plurk.com/API/Dev/null?api_key=#{test_api_key}").
    with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => fixture("dev_null.json"), :headers => {})  
end

def stub_dev_null_login_required
  stub_request(:get, "http://www.plurk.com/API/Dev/null?api_key=#{test_api_key}").
  with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
  to_return(:status => 400, :body => fixture("login_400_login_required.json"), :headers => {})
end
