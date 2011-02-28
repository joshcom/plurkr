module Plurkr
  module Resources; end
  require File.expand_path('../resources/base',__FILE__)
  Dir[File.expand_path('../resources/*.rb', __FILE__)].each{|f| require f}

  # Convenience methods
  def self.plurk; Resources::Plurk; end
  def self.profile; Resources::Profile; end
  def self.user; Resources::User; end
end
