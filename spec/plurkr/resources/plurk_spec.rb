require File.expand_path('../../../spec_helper', __FILE__)

describe Plurkr::Resources::User do
  def stub_plurk_get
    stub_request(:get, "http://www.plurk.com/API/Timeline/getPlurk?plurk_id=645981684&api_key=#{test_api_key}").
    with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => fixture("plurk_get.json"), :headers => {})
  end

  before(:all) do
    configure_client
  end  

  context "retrieving plurks" do
    it "should load single plurks" do
      stub_plurk_get
      plurk = Plurkr::Resources::Plurk.find :plurk_id => 645981684

      # Basic checks to make sure the data loaded
      plurk.qualifier.should eq("wishes")
      plurk.id.should eq(645981684)
      plurk.user.should be_a_kind_of(Plurkr::Resources::User)
    end
  end
end
