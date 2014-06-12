class ConfirmBooking
  include Service

  def initialize(booking, user)
    @booking = booking
    @related_booking = booking.main || booking.return_booking
    @user = user
  end

  def execute
    Booking.transaction do
      @booking.update!(status: :paid, price: @booking.invoice.total, user: @user)
      @related_booking.update!(status: :paid, price: @related_booking.invoice.total , user: @user) if @related_booking
    end
  end
end
