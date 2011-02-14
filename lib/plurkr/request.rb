require File.expand_path('../connection', __FILE__)
require File.expand_path('../errors', __FILE__)

module Plurkr
  # TODO: Throttling
  module Request
    include Plurkr::Connection

    def connection_options(options)
      c_opts = {}
      c_opts[:ssl] = true if options[:ssl]
      c_opts
    end
    
    def request_options(options)
      options[:parameters] || {}
    end

    def request_method(options)
      options[:method] || :get
    end

    def request(options)
      connection(connection_options(options)).send(request_method(options)) do |req|
        req.url options[:resource], 
          { :api_key => self.api_key }.merge(request_options(options)) 
      end
    end

  end
end
