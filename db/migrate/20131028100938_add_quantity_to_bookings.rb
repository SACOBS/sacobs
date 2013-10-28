class AddQuantityToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :quantity, :integer, default: 0
  end
end
