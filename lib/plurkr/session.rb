module Plurkr
  module Session
    def authenticated?
      !@session_cookie.nil?
    end
    
    private
    
    def cookie=(cook)
      @session_cookie=cook
    end
    
    def cookie
      @session_cookie
    end
  end
end