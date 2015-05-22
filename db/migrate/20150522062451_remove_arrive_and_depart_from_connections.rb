class RemoveArriveAndDepartFromConnections < ActiveRecord::Migration
  def change
    remove_columns :connections, :arrive, :depart
  end
end
