class AddIndexToArchivedOnTrips < ActiveRecord::Migration
  def change
    add_index :trips, :archived
  end
end
