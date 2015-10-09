class AddPartialIndexOnArchivedTrips < ActiveRecord::Migration
  def up
    remove_index :trips, :archived
    add_index :trips, :archived, where: 'archived = false'
  end

  def down
    remove_index :trips, :archived
    add_index :trips, :archived
  end
end
