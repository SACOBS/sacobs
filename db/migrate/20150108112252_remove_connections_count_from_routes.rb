class RemoveConnectionsCountFromRoutes < ActiveRecord::Migration
  def change
    remove_column :routes, :connections_count
  end
end
