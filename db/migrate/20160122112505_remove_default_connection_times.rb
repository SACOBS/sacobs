class RemoveDefaultConnectionTimes < ActiveRecord::Migration
  def change
    change_column_default(:connections, :arriving, nil)
    change_column_default(:connections, :leaving, nil)
  end
end
