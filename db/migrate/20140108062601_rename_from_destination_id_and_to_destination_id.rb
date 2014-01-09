class RenameFromDestinationIdAndToDestinationId < ActiveRecord::Migration
  def change
    rename_column :connections, :from_destination_id, :from_id
    rename_column :connections, :to_destination_id, :to_id
  end
end
