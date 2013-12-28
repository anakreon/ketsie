class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.binary :image_data
      t.text :description
      t.references :post, index: true

      t.timestamps
    end
  end
end
