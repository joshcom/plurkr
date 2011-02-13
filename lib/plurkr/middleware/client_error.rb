require 'faraday'

module Plurkr
  module Middleware

    class UnknownClientError < StandardError; end
    class BadRequest < StandardError; end
    class NotAuthorized < StandardError; end
    class Forbidden < StandardError; end
    class NotFound < StandardError; end
    class UnintelligibleResponse < StandardError; end

    class ClientError < Faraday::Response::Middleware
      def self.register_on_complete(env)
        env[:response].on_complete do |r|
          case r[:status].to_i
            when 400
              raise BadRequest, Middleware.extract_error_message(r)
            when 401
              raise NotAuthorized, Middleware.extract_error_message(r)
            when 403
              raise Forbidden, Middleware.extract_error_message(r)
            when 404
              raise NotFound, Middleware.extract_error_message(r)
            when 400..499
              raise UnknownClientError, Middleware.extract_error_message(r)
          end
        end
      end 
    end
  end
end