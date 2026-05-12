class CreateServiceProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :service_products do |t|
      t.references :service, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
