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
  after_save  :set_site
  before_save :refresh_score
  before_validation :default_values

  # scopes
  scope :live,       -> { where('status = ?', 'live') }
  scope :popular,    -> { order('score DESC') }
  scope :recent,     -> { order('created_at DESC') }
  scope :this_week,  -> { where('created_at >= ?', Date.today - 1.week) }
  scope :this_month, -> { where('created_at >= ?', Date.today - 1.month) }

  # validation
  validates :user,      presence: true
  validates :title,     presence: true, length: { minimum: 3 }
  validates :url,       presence: true, format: URI::regexp(%w(http https))
  validates :body,      length: { minimum: 10 }, allow_nil: true
  validates :tag_list,  presence: true, length: { maximum: 5 }
  validates :status,    presence: true, inclusion: { in: %w(pending live) }

  # methods

  # Fetches shares counters using share_counts gem.
  # When everthing is done, it saves all the scores and sums them up with up votes.
  def refresh_score
    shares = ShareCounts.selected self.url, [:facebook, :twitter]
    self.shares_facebook = ( shares[:facebook] || self.shares_facebook )
    self.shares_twitter  = ( shares[:twitter]  || self.shares_twitter )

    self.score = self.shares_facebook + self.shares_twitter + self.plusminus
  end

  # Checks if node is flagged with flags of provided key or
  # with any flags (if key parameter is nil)
  def is_flagged?(key = nil)
    flags = self.flags

    if key
      flags.where(key: key).length > 0
    else
      flags.length > 0
    end
  end

  # Set default values
  def default_values
    self.status ||= 'pending'
  end

  private

  # Check if site exists in database. If not, create it
  # and assign it to the node. If not, find and assign.
  def set_site
    uri  = URI.parse(self.url)
    uri  = URI.parse("http://#{url}") if uri.scheme.nil?
    host = uri.host.downcase
    host = host.start_with?('www.') ? host[4..-1] : host

    self.site = Site.find_or_create_by(address: host)
  end

end
