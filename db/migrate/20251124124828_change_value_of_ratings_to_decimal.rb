class ChangeValueOfRatingsToDecimal < ActiveRecord::Migration[8.0]
  def change
    change_column :ratings, :value, :decimal, precision: 5, scale: 2, null: false, default: 0.0
  end
end
