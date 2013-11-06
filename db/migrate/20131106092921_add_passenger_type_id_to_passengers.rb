class AddPassengerTypeIdToPassengers < ActiveRecord::Migration
  def change
    add_column :passengers, :passenger_type_id, :integer
  end
end
