class AddBillingDateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :billing_date, :datetime
  end
end
