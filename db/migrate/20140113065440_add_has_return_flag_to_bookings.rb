class AddHasReturnFlagToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :has_return, :boolean, default: false
  end
end
