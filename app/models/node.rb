class Node < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  has_many   :flags, foreign_key: 'flagged_id', dependent: :destroy

  # plugins
  acts_as_taggable
  mount_uploader :thumbnail, ThumbnailUploader
  acts_as_voteable
  acts_as_commentable

  # callbacks
  after_save   :set_site

  # scopes
  scope :popular,    -> { order('score DESC') }
  scope :recent,     -> { order('created_at DESC') }
  scope :this_week,  -> { where('created_at >= ?', Date.today - 1.week) }
  scope :this_month, -> { where('created_at >= ?', Date.today - 1.month) }

  # validation
  validates :user,      presence: true
  validates :title,     presence: true, length: { minimum: 3 }
  validates :url,       presence: true, if: :is_link?, format: URI::regexp(%w(http https))
  validates :body,      presence: true, length: { minimum: 10 }, if: :is_text?
  validates :node_type, presence: true, inclusion: 0..1
  validates :tag_list,  presence: true, length: { maximum: 5 }

  # methods

  # Fetch URL and look for first image from there.
  # Than, set it as node thumbnail.
  #
  # TODO: This method should be more smart for sure.
  def fetch_thumbnail
    return unless self.is_link?

    biggest_image = { url: nil, width: 0 }
    doc = Nokogiri::HTML open(self.url)
    
    doc.css('img').each do |img|
      image = { size: FastImage.size(img[:src]), type: FastImage.type(img[:src]) }

      if image[:size] != nil && 
         image[:type] != :gif && 
         image[:size][0] > biggest_image[:width]
         
        biggest_image = { url: img[:src], width: image[:size][0] }
      end
    end
    
    if biggest_image[:url]
      self.remote_thumbnail_url = biggest_image[:url]
      self.save!
      return true
    end
    
    # Set 'needs_thumb' flag
    Flag.build_for(self, 'needs_thumb', self.user, 'Thumbnail has not been fetched automatically.').save!
    return false
  end

  # Update score counter for node.
  def update_score
    self.score = self.plusminus
    self.save!
  end

  # Is node a link?
  def is_link?
    self.node_type == 0 || self.node_type == nil
  end

  # Is node a text?
  def is_text?
    self.node_type == 1
  end

  # Determine if node has flags?
  def is_flagged?(key = nil)
    node = self.flags
    node = node.where(key: key) if key
    node.length > 0
  end

  private

  # Check if site exists in database. If not, create it
  # and assign it to the node. If not, find and assign.
  def set_site
    return unless self.is_link?
    uri  = URI.parse(self.url)
    uri  = URI.parse("http://#{url}") if uri.scheme.nil?
    host = uri.host.downcase
    host = host.start_with?('www.') ? host[4..-1] : host

    self.site = Site.find_or_create_by(address: host)
  end
end
