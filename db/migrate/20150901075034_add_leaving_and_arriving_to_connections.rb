class AddLeavingAndArrivingToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :leaving, :time
    add_column :connections, :arriving, :time
  end
end
