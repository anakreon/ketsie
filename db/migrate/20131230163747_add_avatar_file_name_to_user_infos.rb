class AddAvatarFileNameToUserInfos < ActiveRecord::Migration
  def change
	  add_column :user_infos, :file_name, :text
  end
end
