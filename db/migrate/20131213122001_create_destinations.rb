class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.references :route
      t.references :city
      t.integer :order

      t.timestamps
    end
  end
end
