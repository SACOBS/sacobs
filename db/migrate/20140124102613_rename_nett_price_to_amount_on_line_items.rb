class RenameNettPriceToAmountOnLineItems < ActiveRecord::Migration
  def change
    rename_column :line_items, :nett_price, :amount
  end
end
