class ConfirmBooking
  def initialize(booking)
    @booking = booking.main || booking
    @return_booking =  @booking.return_booking
  end

  def perform(payment_details)
    Booking.transaction do
      [booking, return_booking].compact.each do |booking|
        booking.build_payment_detail(payment_details).save!(validate: false)
        booking.price = booking.invoice.total
        booking.status = :paid
        booking.save!
      end
    end
  end

  private
  attr_reader :booking, :return_booking
end
