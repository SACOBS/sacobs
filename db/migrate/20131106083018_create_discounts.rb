class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.integer :percentage
      t.references :passenger_type

      t.timestamps
    end
  end
end
