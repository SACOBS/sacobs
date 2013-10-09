class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.integer :connection_id
      t.integer :trip_id
      t.datetime :arrive
      t.datetime :depart
      t.integer :available_seats
      t.timestamps
    end
  end
end
