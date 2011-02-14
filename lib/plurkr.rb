require File.expand_path('../plurkr/client', __FILE__)

module Plurkr
  def self.reset
    Thread.current[:plurkr_client] = nil
  end
  
  def self.client(options={})
    Thread.current[:plurkr_client] ||= Plurkr::Client.new(options)
  end
end
