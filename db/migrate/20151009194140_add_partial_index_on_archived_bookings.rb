class AddPartialIndexOnArchivedBookings < ActiveRecord::Migration
  def up
    remove_index :bookings, :archived
    add_index :bookings, :archived, where: 'archived = false'
  end

  def down
    remove_index :bookings, :archived
    add_index :bookings, :archived
  end
end
