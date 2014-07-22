require './lib/sql_commands_uploads'

class Picture

  def initialize(image_attributes, user_id)
    @user_id = user_id
    @image_attributes = image_attributes
    @sql_upload = SqlCommandsUploads.new
  end

  def save
    image_name = @image_attributes[:filename].gsub(' ', '_')

    @sql_upload.create_upload(@user_id, image_name)

    File.open('public/' + image_name, "w") do |f|
      f.write(@image_attributes[:tempfile].read)
    end
  end
end
