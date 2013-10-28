class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :trip_id
      t.decimal :price
      t.string :status

      t.timestamps
    end
  end
end
