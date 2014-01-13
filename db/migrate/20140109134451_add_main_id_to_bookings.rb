class AddMainIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :main_id, :integer
    add_index :bookings, :main_id
  end
end
