class ConfirmBooking
  def initialize(booking, user)
    @booking = booking
    @related_booking = booking.main || booking.return
    @user = user
  end

  def confirm
   Booking.transaction do
    @booking.update!(status: :paid, user: @user)
    @related_booking.update!(status: :paid, user: @user) if @related_booking
   end
   true
  rescue
    false
  end
end