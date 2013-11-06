class CreatePassengerTypes < ActiveRecord::Migration
  def change
    create_table :passenger_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
