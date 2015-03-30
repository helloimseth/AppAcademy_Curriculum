class FixIndexOnContacts < ActiveRecord::Migration
  def change
    remove_index :contacts, :user_id
    add_index :contacts, :email, unique: true 
  end
end
