require "sinatra/base"
require "rack-flash"
# require "active_record"
require "gschool_database_connection"
require "uri"
require_relative "lib/sql_commands"
require_relative "lib/sql_commands_uploads"

class App < Sinatra::Base
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @sql = SqlCommands.new
    @sql_upload = SqlCommandsUploads.new
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get '/' do
    erb :index
  end

  get '/register' do
    erb :register
  end

  post '/register/new' do
    check_if_user_exists
    check_matching_passwords
    @sql.create_user(params[:username], params[:password])
    session[:id] = @sql.user_id(params[:username], params[:password])['id'].to_i
    user_name = @sql.username_array(session[:id]).first['username']
    redirect "/?user_name=#{user_name}"
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
      session[:id] = @sql.user_id(params[:username], params[:password])['id'].to_i
      user_name = @sql.username_array(session[:id]).first['username']
      redirect "/?user_name=#{user_name}"
    end
  end

  post '/logout' do
    session.clear
    flash[:notice] = "Thank you for visiting"
    redirect '/'
  end


  post '/uploads' do

    image = params[:Image]
    puts '*' * 80
    p session[:id]
    puts '*' * 80
    if image
      image_name = image[:filename].gsub(' ', '_')
      @sql_upload.create_upload(session[:id], image_name)

      File.open('public/' + image_name, "w") do |f|
        f.write(image[:tempfile].read)
      end

      redirect "/"
    else
      flash[:notice] = "Please select an image to upload"
      redirect back
    end
  end

  private

  def check_matching_passwords
    if params[:password] != params[:repeat_password]
      flash[:notice] = "passwords must match"
      redirect '/register'
    end
  end

  def check_if_user_exists
    if @sql.user_array(params[:username]) != []
      flash[:notice] = "username is already taken"
      redirect '/register'
    end
  end

end

