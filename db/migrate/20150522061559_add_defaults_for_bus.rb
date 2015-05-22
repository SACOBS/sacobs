class AddDefaultsForBus < ActiveRecord::Migration
  def change
    change_column_default :buses, :capacity, 0
  end
end
