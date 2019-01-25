class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.binary :image_data
      t.text :description
      t.references :post, index: true

      t.timestamps
    end
  end
end
