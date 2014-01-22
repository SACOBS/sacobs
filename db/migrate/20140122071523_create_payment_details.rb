class CreatePaymentDetails < ActiveRecord::Migration
  def change
    create_table :payment_details do |t|
      t.datetime :payment_date
      t.references :bank
      t.references :booking
    end
  end
end
