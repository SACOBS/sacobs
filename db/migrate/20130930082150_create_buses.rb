class CreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.string :name
      t.integer :capacity
      t.string :year
      t.string :model
      t.timestamps
    end
  end
end
