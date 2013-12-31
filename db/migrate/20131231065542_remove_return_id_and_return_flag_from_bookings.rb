class RemoveReturnIdAndReturnFlagFromBookings < ActiveRecord::Migration
  def change
    remove_columns :bookings, :return_id, :return
  end
end
