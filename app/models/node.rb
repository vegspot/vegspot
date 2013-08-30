class Node < ActiveRecord::Base
  belongs_to :user
  belongs_to :site

  # plugins
  acts_as_taggable
  mount_uploader :thumbnail, ThumbnailUploader

  # callbacks
  before_save  :set_site
  after_create :fetch_thumbnail

  # scopes
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

  # Fetch URL and look for first image from there.
  # Than, set it as node thumbnail.
  def fetch_thumbnail
    doc = Nokogiri::HTML(open(self.url))
    image = doc.css('img')
    self.remote_thumbnail_url = image.first[:src]
    self.save!
  end
end
