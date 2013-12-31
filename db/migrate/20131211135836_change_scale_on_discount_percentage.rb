class ChangeScaleOnDiscountPercentage < ActiveRecord::Migration
  def change
    change_column :discounts, :percentage, :decimal, scale: 2, precision: 5
  end
end
