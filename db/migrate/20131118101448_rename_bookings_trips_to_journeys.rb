class RenameBookingsTripsToJourneys < ActiveRecord::Migration
  def change
    rename_table :bookings_trips, :journeys
  end
end
