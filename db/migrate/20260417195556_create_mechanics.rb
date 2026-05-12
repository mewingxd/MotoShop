class CreateMechanics < ActiveRecord::Migration[7.2]
  def change
    create_table :mechanics do |t|
      t.string :full_name
      t.decimal :salary
      t.boolean :active

      t.timestamps
    end
  end
end
