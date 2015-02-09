class AddIndexToContactShares < ActiveRecord::Migration
  def change
    add_index :contact_shares, :user_id, unique: true
    add_index :contact_shares, :contact_id, unique: true
  end
end
