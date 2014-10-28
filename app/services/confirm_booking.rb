class ConfirmBooking
  include Service

  def initialize(booking, user)
    @bookings = [booking, booking.main, booking.return_booking]
    @user = user
  end

  def execute
    Booking.transaction do
      @bookings.each do |booking|
        booking.user = @user
        booking.price = booking.invoice_total
        booking.status = :paid
        save!
      end
    end
  end
end
