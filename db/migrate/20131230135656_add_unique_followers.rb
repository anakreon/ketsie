class AddUniqueFollowers < ActiveRecord::Migration[5.0]
  def change
	  add_index(:followers, [:followed_user_id, :following_user_id], :unique => true)
  end
end
