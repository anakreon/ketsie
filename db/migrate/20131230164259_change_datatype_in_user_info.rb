class ChangeDatatypeInUserInfo < ActiveRecord::Migration[5.0]
  def change
	  remove_column :user_infos, :file_name, :text
	  remove_column :user_infos, :file_type, :text
	  add_column :user_infos, :file_name, :string
	  add_column :user_infos, :file_type, :string

  end
end
