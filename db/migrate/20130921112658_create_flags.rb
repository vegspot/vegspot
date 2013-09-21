class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.references :user, index: true
      t.string :key
      t.string :flagged_type
      t.integer :flagged_id
      t.text :description

      t.timestamps
    end
  end
end
