require File.expand_path('../spec_helper', __FILE__)

describe Plurkr do
  context "when accessing the plurkr client" do
    it "should return a Plurkr client" do
      Plurkr.client.should be_a Plurkr::Client
    end
  end
end
