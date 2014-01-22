class DropBookingsStopsFromDatabase < ActiveRecord::Migration
  def change
    drop_table :bookings_stops
  end
end
