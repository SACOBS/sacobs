class CancelBooking
  include Service

  def initialize(booking, user)
    @booking = booking
    @user = user
  end

  def execute
    Booking.transaction do
      UnassignSeating.execute(@booking.quantity, @booking.stop)
      @booking.update!(status: :cancelled, user: @user)
    end
  end
end