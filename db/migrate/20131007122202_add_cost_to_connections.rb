class AddCostToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :cost, :decimal, precision: 2
  end
end
