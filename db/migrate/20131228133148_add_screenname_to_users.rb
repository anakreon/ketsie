class AddScreennameToUsers < ActiveRecord::Migration[5.0]
  def change
	  add_column :users, :screenname, :string
  end
end
