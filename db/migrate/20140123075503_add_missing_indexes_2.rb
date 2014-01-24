class AddMissingIndexes2 < ActiveRecord::Migration
    def change
      add_index :bookings, :stop_id
      add_index :clients, :bank_id
      add_index :payment_details, :bank_id
      add_index :payment_details, :booking_id
      add_index :payment_details, :user_id
      add_index :seasonal_markups, :user_id
    end
end
