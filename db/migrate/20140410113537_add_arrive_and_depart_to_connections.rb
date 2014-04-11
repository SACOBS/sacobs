class AddArriveAndDepartToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :arrive, :time
    add_column :connections, :depart, :time
  end
end
