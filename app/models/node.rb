class Node < ActiveRecord::Base
  belongs_to :user
  belongs_to :site

  mount_uploader :thumbnail, ThumbnailUploader

  scope :popular, -> { order('created_at ASC') }
  scope :recent,  -> { order('created_at DESC') }
end
