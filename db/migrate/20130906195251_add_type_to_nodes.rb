class AddTypeToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :node_type, :integer
  end
end
