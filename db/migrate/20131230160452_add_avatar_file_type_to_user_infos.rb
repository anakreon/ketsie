class AddAvatarFileTypeToUserInfos < ActiveRecord::Migration
  def change
	  add_column :user_infos, :file_type, :text
  end
end
