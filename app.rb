require "sinatra/base"
require "rack-flash"
# require "active_record"
require "gschool_database_connection"
require "uri"
require_relative "lib/sql_commands"

class App < Sinatra::Base
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @sql = SqlCommands.new
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get '/' do
    erb :index
  end

  get '/register' do
    erb :register
  end

  post '/register/new' do
    if @sql.user_array(params[:username]) != []
      flash[:notice] = "username is already taken"
      redirect '/register'
    else
    check_matching_passwords
    @sql.create_user(params[:username], params[:password])
    session_id
    user_name = @sql.username_array(session_id).first['username']
    redirect "/?user_name=#{user_name}"
    end

  end

  post '/login' do
    if @sql.user_array(params[:username]) == []
      flash[:notice] = "Username doesn't exist"
      redirect '/'
    elsif
      @sql.user_password_array(params[:username]).first['password'] != params[:password]
      flash[:notice] = "Password is incorrect"
      redirect '/'
    else
      session_id
      user_name = @sql.username_array(session_id).first['username']
      redirect "/?user_name=#{user_name}"
    end
  end

  post '/logout' do
    session.clear
    flash[:notice] = "Thank you for visiting"
    redirect '/'
  end

  post '/uploads' do
    # u = User.find_or_create_by_username params[:username]

    image = params[:Image]
    image_name = image[:filename].gsub(' ', '_')
    File.open('public/' + image_name, "w") do |f|
      f.write(image[:tempfile].read)
    end
    redirect "/?image_name=#{image_name}"
  end

  private

  def check_matching_passwords
    if params[:password] != params[:repeat_password]
      flash[:notice] = "passwords must match"
      redirect '/register'
    end
  end

  def session_id
    session[:id] = @sql.user_id_array(params[:username], params[:password]).first['id']
    session[:id]
  end


end

