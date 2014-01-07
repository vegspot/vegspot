class Node < ActiveRecord::Base
  include PgSearch

  # Associations
  belongs_to :user
  belongs_to :site

  # Plugins
  acts_as_taggable
  mount_uploader :thumbnail, ThumbnailUploader
  acts_as_voteable
  acts_as_commentable
  make_flaggable

  # Callbacks
  after_save        :set_site
  after_create      :scrap_thumbnail
  after_create      :refresh_score
  before_validation :default_values

  # Scopes
  scope :live,       -> { where('status = ?', 'live') }
  scope :popular,    -> { order('score DESC') }
  scope :recent,     -> { order('created_at DESC') }
  scope :this_week,  -> { where('created_at >= ?', Date.today - 1.week) }
  scope :this_month, -> { where('created_at >= ?', Date.today - 1.month) }

  # Validation
  validates :user,      presence: true
  validates :title,     presence: true, length: { minimum: 3 }
  validates :url,       presence: true, format: URI::regexp(%w(http https))
  validates :body,      length: { minimum: 10 }, allow_blank: true
  validates :tag_list,  presence: true, length: { maximum: 5 }
  validates :status,    presence: true, inclusion: { in: %w(pending live) }

  # Search scopes
  pg_search_scope :search, against: [:title, :body]

  # Methods

  # Fetches shares counters using share_counts gem.
  # When everthing is done, it saves all the scores and sums them up with up votes.
  def refresh_score
    NodesWorker.perform_async(:refresh_score, self.id)
  end

  def scrap_thumbnail
    return if self.url.nil?
    NodesWorker.perform_async(:scrap_thumbnail, self.id)
  end

  # Set default values
  def default_values
    self.status ||= 'live'
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
