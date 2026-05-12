class CreatePurchases < ActiveRecord::Migration[7.2]
  def change
    create_table :purchases do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :total_price
      t.integer :user_id
      t.datetime :date

      t.timestamps
    end
  end
end
