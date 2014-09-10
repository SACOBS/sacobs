class ChangeLineItemTypeOnLineItemsToInteger < ActiveRecord::Migration
  def change
    change_column :line_items, :line_item_type, 'integer USING CAST(line_item_type AS integer)'
  end
end
