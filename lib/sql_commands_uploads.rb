require "gschool_database_connection"

class SqlCommandsUploads
  def initialize
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  def create_upload(id, filename)
    @database_connection.sql("INSERT INTO uploads (user_id, filepath) VALUES (#{id}, '#{filename}')")
  end

  def user_uploads(user_id)
    @database_connection.sql("SELECT id, filepath FROM uploads WHERE user_id = #{user_id}")
  end

  def delete_upload(id)
    @database_connection.sql("DELETE FROM uploads WHERE id = #{id}")
  end

  def select_upload(id)
    @database_connection.sql("SELECT filepath FROM uploads WHERE id = #{id}")
  end
end
