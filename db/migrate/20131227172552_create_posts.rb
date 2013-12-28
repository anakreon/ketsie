class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :text
      t.datetime :posted_at
      t.datetime :edited_at

      t.timestamps
    end
  end
end
