class AddReferenceToPaymentDetails < ActiveRecord::Migration
  def change
    add_column :payment_details, :reference, :string
  end
end
