class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :surname
      t.string :type
      t.references :bookings

      t.timestamps
    end
  end
end
