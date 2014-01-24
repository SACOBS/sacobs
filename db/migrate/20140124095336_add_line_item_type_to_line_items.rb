class AddLineItemTypeToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :line_item_type, :string
  end
end
