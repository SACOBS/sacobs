class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.decimal :percentage, scale: 2, precision: 5
      t.integer :passenger_type_id
      t.integer :user_id

      t.timestamps
    end
  end
end
