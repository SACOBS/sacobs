class DropTimeTables < ActiveRecord::Migration
  def change
    drop_table :time_tables
  end
end
