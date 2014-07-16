require 'sinatra/base'

class MyApp < Sinatra::Base
  enable :sessions

  get '/' do
    hello
  end

  run Sinatra::Application.run!
end

