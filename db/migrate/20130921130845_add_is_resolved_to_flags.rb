class AddIsResolvedToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :is_resolved, :boolean
  end
end
