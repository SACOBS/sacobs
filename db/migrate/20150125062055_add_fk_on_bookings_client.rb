class AddFkOnBookingsClient < ActiveRecord::Migration
  def change
    add_foreign_key :bookings, :clients, on_delete: :cascade
  end
end
