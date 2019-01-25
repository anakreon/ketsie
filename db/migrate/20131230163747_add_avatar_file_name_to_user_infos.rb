class AddAvatarFileNameToUserInfos < ActiveRecord::Migration[5.0]
  def change
	  add_column :user_infos, :file_name, :text
  end
end
