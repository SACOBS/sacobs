class AddBookingsCountToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :bookings_count, :integer, default: 0

    Trip.unscoped do
      Trip.find_each do |trip|
        Trip.reset_counters(trip.id, :bookings)
      end
    end
  end
end
