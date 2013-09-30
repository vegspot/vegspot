class Flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :node, foreign_key: 'flagged_id', class_name: 'Node'

  validates :key, presence: true, inclusion: { in: %w(needs_thumb save) }
  validates :flagged_type, presence: true
  validates :flagged_id, presence: true
  validates :user_id, presence: true
  validates :description, length: { maximum: 500, minimum: 10 }, allow_nil: true

  # Resolve flag
  def resolve
  	self.is_resolved = true
  	self.save!
  end

  # Build flag for object
  def self.build_for(flagged_object, key, user, description = nil)
  	flag              = Flag.new
  	flag.key          = key
  	flag.flagged_type = flagged_object.class.name
  	flag.flagged_id   = flagged_object.id
  	flag.description  = description
  	flag.user         = user
  	flag
  end
end
