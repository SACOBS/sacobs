class AddGrossPriceAndNettPriceToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :gross_price, :decimal,  precision: 8, scale: 2
    add_column :line_items, :nett_price, :decimal, precision: 8, scale: 2
  end
end
