class CreateServices < ActiveRecord::Migration[7.2]
  def change
    create_table :services do |t|
      t.string :client_name
      t.references :mechanic, null: false, foreign_key: true
      t.string :service_type
      t.string :motorcycle_brand
      t.string :motorcycle_model
      t.string :motorcycle_year
      t.string :motorcycle_plates
      t.text :problem_description
      t.decimal :service_cost
      t.decimal :total_cost
      t.string :status
      t.datetime :end_date

      t.timestamps
    end
  end
end
