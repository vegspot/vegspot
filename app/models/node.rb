class Node < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :remote_thumbnail_url, :thumbnail, :title, :url

  mount_uploader :thumbnail, ThumbnailUploader

  scope :popular, order('created_at ASC')
  scope :recent, order('created_at DESC')
end
