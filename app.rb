require "sinatra/base"
require "rack-flash"
# require "active_record"
require "gschool_database_connection"

class App < Sinatra::Base
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get '/' do
    "hello"
  end

end

