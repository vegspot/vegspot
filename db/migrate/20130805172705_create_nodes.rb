class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :title
      t.text :body
      t.references :user
      t.string :thumbnail

      t.timestamps
    end
    add_index :nodes, :user_id
  end
end
