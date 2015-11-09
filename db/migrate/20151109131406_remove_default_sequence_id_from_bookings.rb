class RemoveDefaultSequenceIdFromBookings < ActiveRecord::Migration
  def change
    change_column_default :bookings, :sequence_id, nil
  end
end
