class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :description
      t.decimal :amount
      t.integer :discount_percentage
      t.decimal :discount_amount
      t.references :invoice

      t.timestamps
    end
  end
end
