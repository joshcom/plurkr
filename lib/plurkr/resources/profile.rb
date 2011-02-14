module Plurkr
  module Resources
    class Profile < Base
      def self.my_profile
        Profile.load( self.get("getOwnProfile") )
      end
 
      def self.public_profile(user_id)
        Profile.load( self.get("getPublicProfile", {:user_id => user_id}) )
      end
    end
  end
end