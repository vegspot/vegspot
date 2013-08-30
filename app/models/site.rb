class Site < ActiveRecord::Base
  belongs_to :node

  def to_s
  	self.address
  end
end