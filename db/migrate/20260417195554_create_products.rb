class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.decimal :price_purchase
      t.decimal :price_buy
      t.integer :stock
      t.integer :stock_min
      t.boolean :refill
      t.text :description
      t.string :image_url
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, :sku, unique: true
  end
end
