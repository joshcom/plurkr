require File.expand_path('../session_base', __FILE__)
require File.expand_path('../cookie_session', __FILE__)

module Plurkr
  module Session    
    class SessionFactory
      def self.create(session_type,client=nil)
        case session_type
        when :cookie 
          return Plurkr::Session::CookieSession.new(client)
        end
        raise SessionTypeDoesNotExist, "A session of type #{session_type} is not supported."
      end
    end
  end
end