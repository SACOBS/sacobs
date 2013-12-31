class ChangeConnectionPercentageToDecimal < ActiveRecord::Migration
  def change
    change_column :connections, :percentage, :decimal, scale: 2, precision: 5
  end
end
