require "gschool_database_connection"

class SqlCommands
  def initialize
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  def create_user(username, password)
    @database_connection.sql("INSERT INTO users (username, password) VALUES ('#{username}', '#{password}')")
  end

  def user_id(username, password)
    @database_connection.sql("SELECT id FROM users WHERE username = '#{username}' and password = '#{password}'").first
  end

  def username_array(session_id)
    @database_connection.sql("SELECT username FROM users WHERE id = '#{session_id}'")
  end

  def all_usernames
    @database_connection.sql("SELECT username FROM users")
  end

  def username(username)
    @database_connection.sql("SELECT username FROM users WHERE username = '#{username}'")
  end

  def user_array(username)
    @database_connection.sql("SELECT username FROM users WHERE username = '#{username}'")
  end

  def user_password_array(username)
    @database_connection.sql("SELECT password FROM users WHERE username = '#{username}'")
  end



  def create_upload(user_id, filename)
    @database_connection.sql("INSERT INTO uploads (user_id, filepath) VALUES ('#{user_id}', '#{filename}')")
  end

end