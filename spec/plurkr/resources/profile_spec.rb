require File.expand_path('../../../spec_helper', __FILE__)

describe Plurkr::Resources do
  def stub_my_profile
    stub_request(:get, "http://www.plurk.com/API/Profile/getOwnProfile?api_key=#{test_api_key}").
    with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => fixture("profile_my.json"), :headers => {})
  end

  def stub_public_profile
    stub_request(:get, "http://www.plurk.com/API/Profile/getPublicProfile?user_id=211356&api_key=#{test_api_key}").
    with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => fixture("profile_public.json"), :headers => {})
  end

  before(:all) do
    stub_login_request
    Plurkr.configure do |p|
      p.api_key = test_api_key
      p.username = test_username
      p.password = test_password
    end
  end  

  context "retrieving profile information" do
    it "should retrieve the current user's profile" do
      stub_my_profile
      profile = Plurkr::Resources::Profile.my
      # Sample a few attributes we know should now be loaded.
      profile.fans_count.should eq(0)
      profile.privacy.should eq("world")
      profile.friends_count.should eq(1)
    end

    it "should retrieve another's profile information" do
      stub_public_profile
      profile = Plurkr::Resources::Profile.for 211356

      # Sample a few attributes we know should now be loaded.
      profile.fans_count.should eq(0)
      profile.privacy.should eq("world")
      profile.friends_count.should eq(1)
    end
  end

  context "Setting User data" do
    it "should set plurks_users to be a list of User objects" do
      stub_my_profile
      profile = Plurkr::Resources::Profile.my
      profile.plurks_users.size.should be(2)
      profile.plurks_users.first.should be_a(Plurkr::Resources::User)
    end

    it "should set user_info to be a User object" do
      stub_my_profile
      profile = Plurkr::Resources::Profile.my
      profile.user_info.should be_a(Plurkr::Resources::User)
    end
  end

  context "Setting Plurk data" do
    it "should set plurks to be a list of Plurk objects" do
      stub_public_profile
      profile = Plurkr::Resources::Profile.for 211356
      profile.plurks.size.should be(20)
      profile.plurks.first.should be_a(Plurkr::Resources::Plurk)
    end
  end

end


