class RemoveDiscountPercentageDiscountAmountGrossPriceFromLineItems < ActiveRecord::Migration
  def change
    remove_columns :line_items, :discount_amount, :discount_percentage, :gross_price
  end
end
