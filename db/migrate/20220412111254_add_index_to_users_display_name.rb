class AddIndexToUsersDisplayName < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :display_name, unique: true
  end
end
