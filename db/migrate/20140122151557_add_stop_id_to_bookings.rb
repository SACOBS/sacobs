class AddStopIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :stop_id, :integer
  end
end
