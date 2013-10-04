class RemoveNodeTypeFromNodes < ActiveRecord::Migration
  def change
  	remove_column :nodes, :node_type
  end
end
