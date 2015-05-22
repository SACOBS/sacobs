class AddIndexOnBookingsArchived < ActiveRecord::Migration
  def change
    add_index :bookings, :archived
  end
end
