class CreatePaymentDetails

  def initialize(booking, attributes)
    @bookings = [booking, booking.main, booking.return_booking].compact
    @payment_detail_attributes = attributes
  end

  def call
    Booking.transaction do
      @bookings.each do |booking|
        booking.create_payment_detail!(@payment_detail_attributes)
        booking.status = :paid
        booking.save!
      end
    end
  end
end






