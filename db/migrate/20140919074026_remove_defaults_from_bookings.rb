class RemoveDefaultsFromBookings < ActiveRecord::Migration
  def change
    change_column_default :bookings, :quantity, nil
    change_column_default :bookings, :has_return, nil
  end
end
