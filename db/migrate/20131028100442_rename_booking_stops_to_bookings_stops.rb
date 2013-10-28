class RenameBookingStopsToBookingsStops < ActiveRecord::Migration
  def change
    rename_table :booking_stops, :bookings_stops
  end
end
