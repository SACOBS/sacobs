class AddPaymentDetailIdToBookings < ActiveRecord::Migration
  def up
    add_column :bookings, :payment_detail_id, :integer
    db.execute("SELECT id, booking_id FROM payment_details").each do |payment_detail_row|
       db.update("UPDATE bookings SET payment_detail_id = #{db.quote(payment_detail_row['id'])} WHERE id = #{db.quote(payment_detail_row['booking_id'])}")
    end
  end

  def down
    remove_column :bookings, :payment_detail_id
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
