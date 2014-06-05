class RenameSeasonalMarkupsToSeasonalDiscounts < ActiveRecord::Migration
  def change
    rename_table :seasonal_markups, :seasonal_discounts
  end
end
