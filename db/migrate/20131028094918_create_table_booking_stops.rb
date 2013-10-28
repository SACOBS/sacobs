class CreateTableBookingStops < ActiveRecord::Migration
  def change
    create_table :booking_stops do |t|
      t.integer :booking_id
      t.integer :stop_id
    end
  end
end
