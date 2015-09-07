class ChangePaymentDateToPaidOnInPaymentDetails < ActiveRecord::Migration
  def up
    rename_column :payment_details, :payment_date, :paid_at
  end

  def down
    rename_column :payment_details, :paid_at, :payment_date
  end
end
