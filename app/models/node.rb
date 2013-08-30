class Node < ActiveRecord::Base
  belongs_to :user

  mount_uploader :thumbnail, ThumbnailUploader

  scope :popular, -> { order('created_at ASC') }
  scope :recent,  -> { order('created_at DESC') }
end
