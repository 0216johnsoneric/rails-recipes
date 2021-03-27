class ChangeQuantityToBeFloatInMeasurements < ActiveRecord::Migration[6.0]
  def change
    change_column :measurements, :quantity, :float
  end
end
