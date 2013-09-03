class SetDefaultValueForNodeScore < ActiveRecord::Migration
  def change
  	change_column :nodes, :score, :integer, default: 0
  end
end
