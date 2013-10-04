class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :from_city_id
      t.integer :to_city_id
      t.integer :distance

      t.timestamps
    end
  end
end
