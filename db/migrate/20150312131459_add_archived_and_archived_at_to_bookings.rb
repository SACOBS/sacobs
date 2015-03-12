class AddArchivedAndArchivedAtToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :archived, :boolean ,default: false
    add_column :bookings, :archived_at, :datetime, null: true
  end
end
