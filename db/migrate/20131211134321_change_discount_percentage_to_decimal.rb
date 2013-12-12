class ChangeDiscountPercentageToDecimal < ActiveRecord::Migration
  def change
    change_column :discounts, :percentage, :decimal, precision: 2
  end
end
