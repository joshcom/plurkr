require 'faraday'

module Plurkr
  module Middleware

    class UnknownServerError < StandardError; end
    class InternalServerError < StandardError; end

    class ServerError < Faraday::Response::Middleware
      def self.register_on_complete(env)
        env[:response].on_complete do |r|
          case r[:status].to_i
            when 500
              raise InternalServerError, Middleware.extract_error_message(r)            
            when 500..599
              raise UnknownServerError, Middleware.extract_error_message(r)
          end
        end
      end    
    end
  end
end