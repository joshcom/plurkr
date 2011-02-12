require 'faraday'
require File.expand_path('../version',__FILE__)
module Plurkr
  module  Configuration
    MUTABLE_OPTION_KEYS = [:api_key,:endpoint,:authentication_resource,:username,:password]
    READONLY_OPTION_KEYS = [:user_agent]

    DEFAULT_ENDPOINT = "www.plurk.com/API/"
    DEFAULT_AUTHENTICATION_RESOURCE = 'Users/login'
    DEFAULT_USER_AGENT = "plurker #{VERSION}"

    def self.included(base)
      base.class_eval do
        attr_accessor *MUTABLE_OPTION_KEYS
        attr_reader *READONLY_OPTION_KEYS
      end
    end

    def reset
      self.api_key = nil
      self.endpoint = DEFAULT_ENDPOINT
      self.authentication_resource = DEFAULT_AUTHENTICATION_RESOURCE
      @user_agent = DEFAULT_USER_AGENT
      @username = @password = nil
    end
  end
end
