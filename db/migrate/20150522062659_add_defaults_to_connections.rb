class AddDefaultsToConnections < ActiveRecord::Migration
  def change
    change_column_default :connections, :percentage, 0
    change_column_default :connections, :distance, 0
    change_column_default :connections, :cost, 0
  end
end
