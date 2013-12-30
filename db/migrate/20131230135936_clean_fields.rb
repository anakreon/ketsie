class CleanFields < ActiveRecord::Migration
  def change
	  remove_column :followers, :created
	  remove_column :likes, :created
	  remove_column :posts, :posted_at
	  remove_column :posts, :edited_at
  end
end
