class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.string :ref_no
      t.decimal :amount
      t.boolean :active, default: true
      t.references :client

      t.timestamps
    end
  end
end
