class DropSubIdFromPosts < ActiveRecord::Migration
  def change
    drop_table :posts, :sub_id
  end
end
