class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :start_city_id
      t.integer :end_city_id
      t.decimal :cost
      t.integer :distance

      t.timestamps
    end
  end
end
