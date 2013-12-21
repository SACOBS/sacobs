class AddFromDestinationIdAndToDestinationIdToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :from_destination_id, :integer
    add_column :connections, :to_destination_id, :integer
  end
end
