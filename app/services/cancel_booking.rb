# Cancels a booking
class CancelBooking
  include Service

  def initialize(booking, user)
    @booking = booking
    @user = user
  end

  def execute
    Booking.transaction do
      UnassignSeating.execute(@booking.quantity, @booking.stop)
      @booking.user = @user
      fail ActiveRecord::Rollback unless @booking.cancel
    end
  end
end
