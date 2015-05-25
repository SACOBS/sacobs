class RemoveHasReturnFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :has_return
  end
end
