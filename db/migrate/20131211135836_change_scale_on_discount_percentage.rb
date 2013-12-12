class ChangeScaleOnDiscountPercentage < ActiveRecord::Migration
  def change
    change_column :discounts, :percentage, :decimal, scale: 5, precision: 2
  end
end
