class AddClientIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :client_id, :integer
  end
end
