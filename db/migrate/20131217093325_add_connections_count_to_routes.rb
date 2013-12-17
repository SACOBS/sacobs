class AddConnectionsCountToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :connections_count, :integer, default: 0
  end
end
