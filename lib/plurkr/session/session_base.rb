module Plurkr
  module Session
    
    class SessionCreationCredentialsNotSupplied < StandardError; end
    class SessionTypeDoesNotExist < StandardError; end
    
    class SessionBase

      attr_accessor :client

      def initialize(clnt=nil)
        self.client = clnt unless clnt.nil?
      end

      def authenticated_request(options)
        raise MustBeImplementedBySubclass
      end
      
      def login
        raise MustBeImplementedBySubclass
      end
 
      def logout
        raise MustBeImplementedBySubclass
      end

      def authenticated?
        raise MustBeImplementedBySubclass
      end
    end
  end
end