module Plurkr
  module Session
    class CookieSession < SessionBase
      
      def initialize(*args)
        @resource = "Users"
        super
      end
      
      def login
        conf = @client.configuration
        unless conf[:username] && conf[:password]
          raise SessionCreationCredentialsNotSupplied
        end
        response = @client.request( :parameters => {:username => conf[:username], 
          :password => conf[:password], :no_data => 1}, :resource => "#{@resource}/login",
          :no_auth => true, :ssl => true)
        self.cookie = response.headers["set-cookie"]
        true
      end
      
      def logout
        return false unless self.authenticated?
        response = @client.request( :resource => "#{@resource}/logout", :no_auth => true)        
        self.cookie = nil
        true
      end
      
      def authenticated_request(options)
        
      end
      
      def authenticated?
        !@session_cookie.nil?
      end
      
      def cookie=(cook)
        @session_cookie=cook
      end
      
      def cookie
        @session_cookie
      end

    end
  end
end