class AddAvatarFileTypeToUserInfos < ActiveRecord::Migration[5.0]
  def change
	  add_column :user_infos, :file_type, :text
  end
end
