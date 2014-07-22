require "gschool_database_connection"

class SqlCommandsUploads
  def initialize
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  def create(user_id, filename)
    @database_connection.sql("INSERT INTO uploads (user_id, filepath) VALUES ('#{user_id}', '#{filename}')").first
  end

end
