class RemoveUserIdIndexFromRoutes < ActiveRecord::Migration
  def change
    remove_index :routes, :user_id
    remove_index :payment_details, :user_id
    remove_index :notes, :user_id
    remove_index :drivers, :user_id
    remove_index :discounts, :user_id
    remove_index :clients, :user_id
    remove_index :cities, :user_id
    remove_index :charges, :user_id
    remove_index :buses, :user_id
    remove_index :bookings, :user_id
  end
end
