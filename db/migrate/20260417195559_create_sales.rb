class CreateSales < ActiveRecord::Migration[7.2]
  def change
    create_table :sales do |t|
      t.references :client, null: false, foreign_key: true
      t.integer :user_id
      t.string :client_name
      t.decimal :subtotal
      t.decimal :tax
      t.decimal :total
      t.datetime :date

      t.timestamps
    end
  end
end
