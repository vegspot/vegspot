class AddSlugToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :slug, :string
  end
end
