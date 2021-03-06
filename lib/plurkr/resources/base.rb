require 'time'

class Plurkr::Resources::Base
  attr_accessor :attributes

  def self.load(attrs)
    self.new.load(attrs)
  end      
  
  def self.resource
    self.respond_to?(:resource_name) ? self.resource_name : self.name.split("::").last
  end
  
  def self.get(action, options={})
    Plurkr.client.authenticated_request({:method => :get,
      :resource => "#{self.resource}/#{action}"}.merge(options)).body
  end

  def self.to_plurk_time(time)
    time.iso8601
  end
  
  def get(action, options={})
    self.class.get(action,options)
  end

  def load(attrs)
    attrs.each { |key,value| self.send("#{key}=",value) }
    self
  end
  
  def initialize(*args)
    @attributes = {}
  end      
  
  def method_missing(method,*args)
    if method.to_s =~ /(=|\?)$/
      case $1
      when "=" 
        attributes[$`] = args.first
      when "?" 
        attributes.include?($`)
      end
    else
      attributes[method.to_s]
    end
  end
end
