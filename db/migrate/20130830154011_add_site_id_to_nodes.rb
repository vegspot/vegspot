class AddSiteIdToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :site_id, :integer
  end
end
