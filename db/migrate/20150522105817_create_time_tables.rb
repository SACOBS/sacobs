class CreateTimeTables < ActiveRecord::Migration
  def change
    create_table :time_tables do |t|
      t.time :arrive
      t.time :depart
      t.integer :direction, default: 0
      t.belongs_to :city, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
