class AddReturnIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :return_id, :integer
  end
end
