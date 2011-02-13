require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../../../../lib/plurkr/session/session_factory',__FILE__)

describe Plurkr::Session::SessionFactory do  
  context "when creating a session object" do
    it "should return a CookieSession" do
      Plurkr::Session::SessionFactory.create(:cookie).should be_a(Plurkr::Session::CookieSession)
    end
    it "should raise an error on an unsupported session type" do
      expect { 
        Plurkr::Session::SessionFactory.create(:no_exist) 
      }.to raise_error(Plurkr::Session::SessionTypeDoesNotExist)
    end
  end
end