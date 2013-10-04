class AddRouteIdToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :route_id, :integer
  end
end
