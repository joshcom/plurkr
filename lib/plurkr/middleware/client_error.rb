require 'faraday'

module Plurkr
  module Middleware

    LOGIN_REQUIRED_MESSAGE = "Requires login"
    
    class UnknownClientError < StandardError; end
      
    # 400 Errors
    class BadRequest < StandardError; end
    class LoginRequired < StandardError; end

    # 401+ Errors
    class NotAuthorized < StandardError; end
    class Forbidden < StandardError; end
    class NotFound < StandardError; end
    class UnintelligibleResponse < StandardError; end

    class ClientError < Faraday::Response::Middleware
      def self.register_on_complete(env)
        env[:response].on_complete do |r|
          case r[:status].to_i
            when 400
              mess = Middleware.extract_error_message(r)
              case mess 
              when LOGIN_REQUIRED_MESSAGE
                raise LoginRequired, mess
              else
                raise BadRequest, mess
              end
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