require 'faraday_middleware'
require File.expand_path('../middleware/middleware',__FILE__)

module Plurkr
  module Connection
    private
    
    # options:
    # * :ssl => true if https should be used.  false by default.
    # * :cookie => if present, the :Cookie header will be set.
    def connection(options={})
      Faraday::Connection.new(faraday_options(options)) do |builder|
        builder.adapter Faraday.default_adapter
        builder.use Faraday::Response::ParseJson
        builder.use Plurkr::Middleware::ClientError
        builder.use Plurkr::Middleware::ServerError
      end
    end

    def protocol(options={})
      options[:ssl] ? "https://" : "http://"
    end

    def faraday_options(options={})
      f_opts = {:url => "#{protocol(options)}#{self.endpoint}"}
      f_opts[:headers] = { :Cookie => options[:cookie] } if options[:cookie] 
      f_opts
    end
  end
end
