module Plurkr

  # Convenience method
  def self.profile; Resources::Profile; end

  module Resources
    class Profile < Base
      def self.my
        Profile.load( self.get("getOwnProfile") )
      end
      def self.for(user_id)
        Profile.load( self.get("getPublicProfile", :parameters => {:user_id => user_id}) )
      end
    end
  end
end