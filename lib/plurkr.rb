require File.expand_path('../plurkr/client', __FILE__)

module Plurkr
  def self.reset
    Thread.current[:plurkr_client] = nil
  end
  
  def self.client(options={})
    Thread.current[:plurkr_client] ||= Plurkr::Client.new(options)
  end
  
  def self.method_missing(method,*args,&block)
    if self.client.respond_to?(method)
      return self.client.send(method,*args,&block)
    end
    super
  end
  
  def self.respond_to?(method)
    self.client.respond_to?(method) || super
  end
end
