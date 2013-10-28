class AddExpiryDateToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :expiry_date, :datetime
  end
end
