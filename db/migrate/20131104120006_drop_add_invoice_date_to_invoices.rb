class DropAddInvoiceDateToInvoices < ActiveRecord::Migration
  def change
    drop_table :add_invoice_date_to_invoices if ActiveRecord::Base.connection.table_exists? 'add_invoice_date_to_invoices'


  end
end
