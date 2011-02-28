module Plurkr
  module Resources
    class Plurk < Base

      VALID_FILTER_VALUES = [:only_user, :only_responded, :only_private, :only_favorite]

      def self.resource_name
        "Timeline"
      end

      def self.process_plurk_result( plurk_hash )
        p = plurk_hash["plurk"]
        p["user"] = User.load(plurk_hash["user"])
        p
      end

      def self.find(options={})
        raise ArgumentError, "An options hash must be passed" unless options.is_a?(Hash)
        unless !options.include?(:filter) || VALID_FILTER_VALUES.include?(options[:filter])
          raise ArgumentError, "options[:filter] must be one of the following: #{VALID_FILTER_VALUES.join(',')}"
        end
        action = if options[:plurk_id]
                   "getPlurk"
                 elsif options[:unread]
                   options.delete :unread
                   "getUnreadPlurks"
                 else
                   "getPlurks"
                 end
        options[:offset] = Plurk.to_plurk_time(options[:offset]) if options.include?(:offset)
        resp = self.get(action,{:parameters => options})

        case action
        when "getPlurk"
          self.load(self.process_plurk_result(resp))
        else
          resp["plurks"].map do |p|
            self.load(p)
          end
        end
      end
    end
  end
end
