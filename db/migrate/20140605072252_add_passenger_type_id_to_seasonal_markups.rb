class AddPassengerTypeIdToSeasonalMarkups < ActiveRecord::Migration
  def change
    add_column :seasonal_markups, :passenger_type_id, :integer
  end
end
