class AddDefaultsToBookings < ActiveRecord::Migration
  def change
    change_column_default :bookings, :status, 0
    change_column_default :bookings, :price, 0
    change_column_default :bookings, :quantity, 0
    change_column_default :bookings, :has_return, false
  end
end
