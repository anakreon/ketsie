class RenameColumnFollowers2 < ActiveRecord::Migration
  def change
	rename_column :followers, :followed_user, :followed_user_id
  	rename_column :followers, :following_user, :following_user_id
  end
end
