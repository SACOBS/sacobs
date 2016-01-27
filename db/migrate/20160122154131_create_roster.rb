class CreateRoster < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.belongs_to :driver
      t.belongs_to :trip

      t.timestamps
    end

    execute 'insert into rosters(driver_id, trip_id) select driver_id, trip_id from drivers_trips'

    # drop the old table
    drop_table :drivers_trips
  end

  def down
    # This leaves the id and timestamps fields intact
    rename_table :rosters, :drivers_trips
  end
end
