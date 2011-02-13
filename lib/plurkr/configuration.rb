require 'faraday'
require File.expand_path('../version',__FILE__)
require File.expand_path('../session/session_factory', __FILE__)

module Plurkr
  module  Configuration
    MUTABLE_OPTION_KEYS = [:api_key,:session_type,:endpoint,:authentication_resource,:username,:password]
    READONLY_OPTION_KEYS = [:user_agent,:session]

    DEFAULT_ENDPOINT = "www.plurk.com/API/"
    DEFAULT_AUTHENTICATION_RESOURCE = 'Users/login'
    DEFAULT_USER_AGENT = "plurker #{VERSION}"
    DEFAULT_SESSION_TYPE = :cookie

    def self.included(base)
      base.class_eval do
        attr_accessor *MUTABLE_OPTION_KEYS
        attr_reader *READONLY_OPTION_KEYS
      end
    end

    def configuration
      MUTABLE_OPTION_KEYS.inject({}) do |conf,key|
        conf.merge!(key=>self.send(key))
      end
    end
    
    def reset
      self.api_key = nil
      self.session_type = DEFAULT_SESSION_TYPE
      self.endpoint = DEFAULT_ENDPOINT
      self.authentication_resource = DEFAULT_AUTHENTICATION_RESOURCE
      @user_agent = DEFAULT_USER_AGENT
      @username = @password = nil
      @session = Plurkr::Session::SessionFactory.create(self.session_type,self)
    end
  end
end
