module Plurkr
  module Session
    class CookieSession < SessionBase
      
      MAX_LOGIN_ATTEMPTS = 2
      
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

      # Makes an authenticated_request, allowing the following options:
      # * :ssl => (false) if true, https will be used
      # * :parameters => A hash of parameters to send with the request.
      # If not authenticated, login will be called before the request is made.
      # If a "LoginRequired" exception is raised, another login attempt will be made
      # and then the request will be repeated, up to MAX_LOGIN_ATTEMPTS times.
      def authenticated_request(options)
        self.login unless self.authenticated?
        req = nil
        MAX_LOGIN_ATTEMPTS.times do |t|
          begin
            options[:cookie] = self.cookie
            req = @client.request(options)
            break
          rescue Plurkr::Middleware::LoginRequired => e
            self.login 
            next
          end
        end
        raise Plurkr::Middleware::LoginRequired if req.nil?
        req
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