require File.expand_path('../connection', __FILE__)
require File.expand_path('../errors', __FILE__)

module Plurkr
  module Request
    include Plurkr::Connection

    def connection_options(options)
      c_opts = {}
      c_opts[:ssl] = true if options[:ssl]
      unless self.authenticated? || options[:no_auth]
        c_opts[:cookie] = self.cookie
      end
      c_opts
    end
    
    def request_options(options)
      options[:parameters] || {}
    end

    def request_method(options)
      options[:method] || :get
    end
    
    def request(options)
      if (options[:username] && options[:password])
        request_authentication(options)
      else
        request_resource(options)
      end
    end    

    def request_authentication(options)
      response = connection(:ssl=>true).get do |req|
        req.url self.authentication_resource,
          { :api_key => self.api_key, :no_data => "1" }.merge(options) 
      end
      
      self.cookie = response.headers["set-cookie"]
    end

    def request_resource(options)
      unless self.authenticated? || options[:no_auth]
        raise Plurkr::Unauthenticated, "You must create a session before requesting a resource"
      end

      connection(connection_options(options)).send(request_method(options)) do |req|
        req.url options[:resource], 
          { :api_key => self.api_key }.merge(request_options(options)) 
      end
    end

  end
end
