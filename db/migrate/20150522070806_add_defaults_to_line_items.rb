class AddDefaultsToLineItems < ActiveRecord::Migration
  def change
    change_column_default :line_items, :amount, 0
  end
end
