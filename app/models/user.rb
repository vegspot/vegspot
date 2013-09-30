class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :omniauthable

  has_many :services, dependent: :destroy
  has_many :nodes
  has_many :flags

  # plugins
  acts_as_voter
  has_karma :nodes, :as => :user, weight: [1,1]

  def to_s
    self.display_name
  end

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

  # Alias method for setting a flag of type 'save' on node
  def save(node)
    flag = self.flags.where(key: 'save', flagged_type: 'Node', flagged_id: node.id).first
    
    if flag
      flag.destroy
    else
      Flag.build_for(node, 'save', self).save!
    end
  end

  def saved?(node)
    self.flags.where(key: 'save', flagged_type: 'Node', flagged_id: node.id).first
  end
end
