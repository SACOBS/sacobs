class AddDefaultLeavingAndArrivingTimesToConnections < ActiveRecord::Migration
  def up
    change_column :connections, :arriving, :time, default: :now
    change_column :connections, :leaving, :time, default: :now
  end

  def down
    change_column :connections, :arriving, :time, default: nil
    change_column :connections, :leaving, :time, default: nil
  end
end
