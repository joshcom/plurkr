module Plurkr
  module Resources
    class Profile < Base
      def self.my
        Profile.load( self.get("getOwnProfile") )
      end
      def self.for(user_id)
        Profile.load( self.get("getPublicProfile", :parameters => {:user_id => user_id}) )
      end

      def user_info=(user)
        attributes["user_info"] = User.load(user)
      end

      def plurks_users=(users)
        user_list = []
        users.map do |id,user_data|
          user_list << User.load(user_data)
        end
        attributes["plurks_users"] = user_list
      end

      def plurks=(plurk_list)
        attributes["plurks"] = plurk_list.map do |p|
          Plurk.load(p)
        end
      end
    end
  end
end
