require './lib/sql_commands_uploads'
require 'aws-sdk'

class Picture

  def self.create(image_attributes, user_id)
    image_name = image_attributes[:filename].gsub(' ', '_')

    sql_upload = SqlCommandsUploads.new
    sql_upload.create_upload(user_id, image_name)

    s3 = AWS::S3.new(
      :access_key_id => ENV['ACCESS_KEY_ID'],
      :secret_access_key => ENV['SECRET_ACCESS_KEY']
    )
    bucket = s3.buckets["frame_it_bucket"]
    f = bucket.objects[image_name]
    f.write(image_attributes[:tempfile].read)
  end

  def upload(image)

    s3 = AWS::S3.new(
      :access_key_id => ENV['ACCESS_KEY_ID'],
      :secret_access_key => ENV['SECRET_ACCESS_KEY']
    )

    s3.buckets["frame_it_bucket"].objects[image].public_url

  end

  def delete(image)
    
  end
end
