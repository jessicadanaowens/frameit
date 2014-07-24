require './lib/sql_commands_uploads'
require 'aws-sdk'

class Picture

  def initialize(image_attributes, user_id)
    @user_id = user_id
    @image_attributes = image_attributes
    @sql_upload = SqlCommandsUploads.new
  end

  def save
    image_name = @image_attributes[:filename].gsub(' ', '_')



    @sql_upload.create_upload(@user_id, image_name)


    s3 = AWS::S3.new(
      :access_key_id => ENV['ACCESS_KEY_ID'],
      :secret_access_key => ENV['SECRET_ACCESS_KEY']
    )
    bucket = s3.buckets["frame_it_bucket"]
    f = bucket.objects[image_name]
    puts '*' * 80
    p bucket
    p f
    puts '*' * 80
    f.write(@image_attributes[:tempfile].read)
  end
end
