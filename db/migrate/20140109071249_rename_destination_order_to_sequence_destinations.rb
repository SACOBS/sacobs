class RenameDestinationOrderToSequenceDestinations < ActiveRecord::Migration
  def change
    rename_column :destinations, :destination_order, :sequence
  end
end
