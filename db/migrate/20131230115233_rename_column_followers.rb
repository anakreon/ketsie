class RenameColumnFollowers < ActiveRecord::Migration[5.0]
  def change
	rename_column :followers, :user_followed_id, :followed_user
  	rename_column :followers, :user_following_id, :following_user
  end
end
