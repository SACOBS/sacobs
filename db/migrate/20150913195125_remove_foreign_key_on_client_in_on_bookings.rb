class RemoveForeignKeyOnClientInOnBookings < ActiveRecord::Migration
  def up
    remove_foreign_key :bookings, :client
  end

  def down
    add_foreign_key :bookings, :client
  end
end
