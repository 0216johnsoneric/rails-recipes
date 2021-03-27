class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :pet_category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
