class AddReturnFlagToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :return, :boolean
  end
end
