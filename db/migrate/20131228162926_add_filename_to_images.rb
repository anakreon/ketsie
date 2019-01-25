class AddFilenameToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :file_name, :string
  end
end
