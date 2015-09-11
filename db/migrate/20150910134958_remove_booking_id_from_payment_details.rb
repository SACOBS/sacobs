class RemoveBookingIdFromPaymentDetails < ActiveRecord::Migration
  def up
    remove_column :payment_details, :booking_id
  end

  def down
    add_column :payment_details, :booking_id, :integer
  end

end
