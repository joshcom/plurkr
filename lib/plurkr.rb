require File.expand_path('../plurkr/client', __FILE__)

module Plurkr
  def self.plurkr(options={})
    Plurkr::Client.new(options)
  end
end
