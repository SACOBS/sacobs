class RenameOrderToDestinationOrderOnDestinations < ActiveRecord::Migration
  def change
    rename_column :destinations, :order, :destination_order
  end
end
