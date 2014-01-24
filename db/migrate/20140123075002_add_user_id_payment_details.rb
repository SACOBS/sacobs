class AddUserIdPaymentDetails < ActiveRecord::Migration
  def change
    add_column :payment_details, :user_id, :integer
  end
end
