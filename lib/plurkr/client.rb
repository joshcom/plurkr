require File.expand_path('../configuration', __FILE__)
require File.expand_path('../session', __FILE__)
require File.expand_path('../request', __FILE__)
module Plurkr
  class Client
    include Configuration
    include Session    
    include Request
    def initialize(options={})
      self.reset
      Configuration::MUTABLE_OPTION_KEYS.each do |key|
        self.send "#{key}=", options[key] if options.include?(key)
      end
    end
  end
end
