class RemoveTypeFromPassengers < ActiveRecord::Migration
  def change
    remove_column :passengers, :type
  end
end
