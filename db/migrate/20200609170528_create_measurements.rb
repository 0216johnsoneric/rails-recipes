class CreateMeasurements < ActiveRecord::Migration[6.0]
  def change
    create_table :measurements do |t|
      t.integer :quantity
      t.string :unit
      t.integer :ingredient_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
