class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null:false
      t.string :url
      t.text :content
      t.integer :user_id

      t.timestamps
    end

    add_index :posts, :sub_id
    add_index :posts, :user_id
  end
end
