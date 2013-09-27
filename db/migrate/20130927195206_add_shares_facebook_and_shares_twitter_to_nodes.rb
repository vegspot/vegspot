class AddSharesFacebookAndSharesTwitterToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :shares_facebook, :integer
    add_column :nodes, :shares_twitter, :integer
  end
end
