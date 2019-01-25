class AddFiletypeToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :file_type, :string
  end
end
