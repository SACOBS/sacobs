class AddNameToSeasonalDiscounts < ActiveRecord::Migration
  def change
    add_column :seasonal_discounts, :name, :string
  end
end
