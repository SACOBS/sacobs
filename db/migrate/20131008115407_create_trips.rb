class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :route_id
      t.integer :bus_id

      t.timestamps
    end
  end
end
