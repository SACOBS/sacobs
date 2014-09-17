class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :seasonal_discounts, :passenger_type_id
  end
end
