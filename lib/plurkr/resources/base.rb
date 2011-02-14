module Plurkr
  module Resources
    class Base

      attr_accessor :attributes

      def initialize(options={})
        @client=options[:client]
        @attributes = {}
      end

      def resource
        self.respond_to?(:resource_name) ? self.resource_name : self.class.name
      end
      
      def load(attrs)
        attrs.each { |key,value| self.send(key,value) }
      end
      
      def get(action, options={})
        @client.authenticated_request({:method => :get,
          :resource => "#{resource}/#{action}"}.merge(options))
      end

      def method_missing(method,*args)
        if method.to_s =~ /(=|\?)$/
          case $1
          when "=" 
            attributes[$`] = args.first
          when "?" 
            attributes.include?($`)
          end
        else
          attributes[method]
        end
      end
    end
  end
end