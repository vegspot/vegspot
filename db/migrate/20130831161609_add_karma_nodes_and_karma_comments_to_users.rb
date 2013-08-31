class AddKarmaNodesAndKarmaCommentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :karma_nodes, :integer, default: 0
    add_column :users, :karma_comments, :integer, default: 0
  end
end
