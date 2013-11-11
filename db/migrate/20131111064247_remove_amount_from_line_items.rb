class RemoveAmountFromLineItems < ActiveRecord::Migration
  def change
    remove_column :line_items, :amount
  end
end
