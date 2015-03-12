class AddArchivedAndArchivedAtToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :archived, :boolean, default: false
    add_column :trips, :archived_at, :datetime, null: true
  end
end
