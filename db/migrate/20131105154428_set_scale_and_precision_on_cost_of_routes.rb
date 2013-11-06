class SetScaleAndPrecisionOnCostOfRoutes < ActiveRecord::Migration
  def change
    change_column :routes, :cost, :decimal , precision: 8, scale: 2
  end
end
