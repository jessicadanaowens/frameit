class Upload < ActiveRecord::Base
  belongs_to :user

  mount_uploader :filepath, Uploader
end