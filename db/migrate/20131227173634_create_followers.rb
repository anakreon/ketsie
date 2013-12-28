class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.references :user_followed, index: true
      t.references :user_following, index: true
      t.datetime :created

      t.timestamps
    end
  end
end
