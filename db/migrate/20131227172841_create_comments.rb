class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.string :text
      t.references :post, index: true
      t.datetime :posted_at

      t.timestamps
    end
  end
end
