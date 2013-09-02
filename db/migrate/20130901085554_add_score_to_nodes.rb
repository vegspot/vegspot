class AddScoreToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :score, :integer
  end
end
