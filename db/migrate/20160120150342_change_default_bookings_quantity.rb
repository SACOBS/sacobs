class ChangeDefaultBookingsQuantity < ActiveRecord::Migration
  def change
    change_column_default(:bookings, :quantity, 1)
  end
end
