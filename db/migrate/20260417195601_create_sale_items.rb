class CreateSaleItems < ActiveRecord::Migration[7.2]
  def change
    create_table :sale_items do |t|
      t.references :sale, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.string :image_url

      t.timestamps
    end
  end
end
