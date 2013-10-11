class CreateDriversTrips < ActiveRecord::Migration
  def change
    create_table :drivers_trips do |t|
      t.integer :driver_id
      t.integer :trip_id
    end
  end
end
