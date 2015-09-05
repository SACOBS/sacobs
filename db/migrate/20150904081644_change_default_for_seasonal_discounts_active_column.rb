class ChangeDefaultForSeasonalDiscountsActiveColumn < ActiveRecord::Migration
  def change
    change_column_default :seasonal_discounts, :active, true
  end
end
