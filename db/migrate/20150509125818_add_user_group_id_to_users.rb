class AddUserGroupIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_group_id, :integer, default: 1
  end
end
