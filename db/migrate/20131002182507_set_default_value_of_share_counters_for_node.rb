class SetDefaultValueOfShareCountersForNode < ActiveRecord::Migration
  def change
  	change_column :nodes, :shares_facebook, :integer, default: 0
  	change_column :nodes, :shares_twitter, :integer, default: 0
  end
end
