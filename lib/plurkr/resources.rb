module Plurkr
  module Resources; end
  Dir[File.expand_path('../resources/*.rb', __FILE__)].each{|f| require f}
end