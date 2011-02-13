require File.expand_path('../client_error',__FILE__)
require File.expand_path('../server_error',__FILE__)

module Plurkr
  module Middleware
    def self.extract_error_message(response)
      return "" unless response && response.include?(:body) && response[:body].include?("error_text")
      response[:body]["error_text"]
    end
  end
end