class AddSequenceIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :sequence_id, :integer
  end
end
