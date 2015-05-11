class ChangeColumnNameInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :user_group_id, :group_id
  end
end
