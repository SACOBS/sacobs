class SetScaleAndPrecisionOnLineItems < ActiveRecord::Migration
  def change
    change_column :line_items, :amount, :decimal , precision: 8, scale: 2
    change_column :line_items, :discount_amount, :decimal , precision: 8, scale: 2
  end
end
