class CreateBookingsTrips < ActiveRecord::Migration
  def change
    create_table :bookings_trips do |t|
      t.integer :trip_id
      t.integer :booking_id
      t.boolean :return

      t.timestamps
    end
  end
end
