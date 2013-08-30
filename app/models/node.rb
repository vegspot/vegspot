class Node < ActiveRecord::Base
  belongs_to :user
  belongs_to :site

  before_save :set_site

  mount_uploader :thumbnail, ThumbnailUploader

  scope :popular, -> { order('created_at ASC') }
  scope :recent,  -> { order('created_at DESC') }


  private

  # Check if site exists in database. If not, create it
  # and assign it to the node. If not, find and assign.
  def set_site
    uri = URI.parse(self.url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    host = uri.host.downcase
    host.start_with?('www.') ? host[4..-1] : host

    self.site = Site.find_or_create_by(address: host)
  end
end
