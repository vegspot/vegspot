class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :omniauthable

  has_many :services, :dependent => :destroy
  has_many :nodes

  # plugins
  acts_as_voter
  has_karma :nodes, :as => :user, weight: [1,1]

  def avatar_url(size = 'small')
    if self.services.with_facebook.length > 0
      # width: 200px
      # <img src="https://graph.facebook.com/<?= $fid ?>/picture?type=large">
      "https://graph.facebook.com/#{self.services.with_facebook.first.uid}/picture"
    end
  end

  # Modify user karma points for nodes or for comments
  def update_karma_counter
    self.karma_nodes = self.karma
    self.save!
  end
end
