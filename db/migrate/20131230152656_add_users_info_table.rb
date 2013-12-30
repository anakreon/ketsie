class AddUsersInfoTable < ActiveRecord::Migration
  def change
	create_table :user_infos do |t|
  		t.binary :avatar_image
		t.text :personal_description
	end
  end
end
