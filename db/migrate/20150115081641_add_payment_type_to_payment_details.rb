class AddPaymentTypeToPaymentDetails < ActiveRecord::Migration
  def change
    add_column :payment_details, :payment_type, :string
  end
end
