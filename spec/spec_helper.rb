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

def fixture(file)
  File.new( File.expand_path('../fixtures', __FILE__) + "/" + file)
end

def stub_login_request
  stub_request(:get, "https://www.plurk.com/API/Users/login?api_key=#{test_api_key}&no_data=1&password=#{test_password}&username=#{test_username}").
    with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => fixture("login.json"), :headers => {
      "set-cookie" => "my cookie"
    })
end

def stub_logout_request
  stub_request(:get, "http://www.plurk.com/API/Users/logout?api_key=#{test_api_key}").
    with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => fixture("logout.json"), :headers => {})
end