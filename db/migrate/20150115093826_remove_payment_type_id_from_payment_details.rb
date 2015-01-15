class RemovePaymentTypeIdFromPaymentDetails < ActiveRecord::Migration
  def change
    remove_column :payment_details, :payment_type_id
  end
end
