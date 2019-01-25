class AddUserIdToUserInfos < ActiveRecord::Migration[5.0]
  def change
	  add_column :user_infos, :user_id, :integer
	  add_index :user_infos, :user_id, :unique => true
  end
end
