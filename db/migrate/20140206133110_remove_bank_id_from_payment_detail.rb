class RemoveBankIdFromPaymentDetail < ActiveRecord::Migration
  def change
    remove_column :payment_details, :bank_id
    add_column :payment_details, :payment_type_id, :integer
  end
end
