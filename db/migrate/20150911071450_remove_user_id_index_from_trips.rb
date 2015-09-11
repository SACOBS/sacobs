class RemoveUserIdIndexFromTrips < ActiveRecord::Migration
  def change
    remove_index :trips, :user_id
  end
end
