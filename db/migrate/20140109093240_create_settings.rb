class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :booking_expiry_period

      t.timestamps
    end
  end
end
