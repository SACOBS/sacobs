class ChangeConnectionPercentageToDecimal < ActiveRecord::Migration
  def change
    change_column :connections, :percentage, :decimal, scale: 5, precision: 2
  end
end
