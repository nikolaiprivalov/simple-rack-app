require 'pry'

Dir['./app/**/*.rb'].sort.each { |f| require f }
Dir['./middleware/**/*.rb'].sort.each { |f| require f }

use Rack::Reloader, 0

use ErrorCatcher
use RequestLogger
use StaticServer
run HelloWorld.new
