class AddUserIdToDiscounts < ActiveRecord::Migration
  def change
    add_column :discounts, :user_id, :integer
  end
end
