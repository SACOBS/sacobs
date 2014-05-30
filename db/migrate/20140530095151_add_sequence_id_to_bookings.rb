class AddSequenceIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :sequence_id, :integer unless column_exists?(:bookings, :sequence_id)
  end
end
