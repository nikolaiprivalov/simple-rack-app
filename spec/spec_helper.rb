require 'pry'
require 'rack/test'

Dir['./app/**/*.rb'].sort.each { |f| require f }
Dir['./middleware/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
