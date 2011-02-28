require File.expand_path('../../spec_helper', __FILE__)

describe Plurkr::Resources do
  context "helper methods" do
    it "should match the appropriate class" do
      Plurkr.plurk.should be(Plurkr::Resources::Plurk)
      Plurkr.profile.should be(Plurkr::Resources::Profile)
      Plurkr.user.should be(Plurkr::Resources::User)
    end
  end
end
