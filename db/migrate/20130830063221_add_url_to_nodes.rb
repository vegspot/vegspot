class AddUrlToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :url, :string
  end
end
