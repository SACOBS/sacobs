class AddPercentageToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :percentage, :decimal, precision: 2
  end
end
