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
  after_save :set_site
  after_save :refresh_score

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

  # Fetches shares counters using share_counts gem.
  # When everthing is done, it saves all the scores and sums them up with up votes.
  def refresh_score
    shares = ShareCounts.selected self.url, [:facebook, :twitter]
    self.shares_facebook = shares[:facebook]
    self.shares_twitter  = shares[:twitter]
    self.score = self.shares_facebook + self.shares_twitter + self.plusminus
    self.save!
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
