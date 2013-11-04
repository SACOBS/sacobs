class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :booking

      t.timestamps
    end
  end
end
