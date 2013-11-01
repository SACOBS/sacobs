class RenamePassengersBookingsIdToBookingId < ActiveRecord::Migration
  def change
    rename_column :passengers, :bookings_id, :booking_id
  end
end
