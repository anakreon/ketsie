class AddUniqueFollowers < ActiveRecord::Migration
  def change
	  add_index(:followers, [:followed_user_id, :following_user_id], :unique => true)
  end
end
