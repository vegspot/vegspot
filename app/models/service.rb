class Service < ActiveRecord::Base
  belongs_to :user

  scope :with_facebook, -> { where(provider: 'facebook') }
end
