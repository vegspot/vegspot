class Node < ActiveRecord::Base
  belongs_to :user
  belongs_to :site

  # plugins
  acts_as_taggable
  mount_uploader :thumbnail, ThumbnailUploader
  acts_as_voteable
  acts_as_commentable

  # callbacks
  before_save  :set_site
  after_create :fetch_thumbnail

  # scopes
  scope :popular,    -> { order('score DESC') }
  scope :recent,     -> { order('created_at DESC') }
  scope :this_week,  -> { where('created_at > ?', Date.today - 1.week) }
  scope :this_month, -> { where('created_at > ?', Date.today - 1.month) }

  # methods

  # Fetch URL and look for first image from there.
  # Than, set it as node thumbnail.
  def fetch_thumbnail
    return if self.node_type != 0
    boilerpipe = JSON.parse open("http://boilerpipe-web.appspot.com/extract?url=#{self.url}&extractor=ArticleExtractor&output=json&extractImages=3").read
    
    if boilerpipe['response']['images'].any?
      self.remote_thumbnail_url = boilerpipe['response']['images'].first['src']
      self.save!
    else
      false
    end
  end

  # Update score counter for node.
  def update_score
    self.score = self.plusminus
    self.save!
  end

  private

  # Check if site exists in database. If not, create it
  # and assign it to the node. If not, find and assign.
  def set_site
    return if self.node_type != 0
    uri = URI.parse(self.url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    host = uri.host.downcase
    host.start_with?('www.') ? host[4..-1] : host

    self.site = Site.find_or_create_by(address: host)
  end
end
