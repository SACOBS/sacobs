class ChangePrecisionAndScaleOfCostConnections < ActiveRecord::Migration
  def change
    change_column :connections, :cost, :decimal , precision: 8, scale: 2
  end
end
