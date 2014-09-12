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
      @booking.has_return = false if @booking.has_return?
      @booking.main_id = nil if @booking.is_return?
      @booking.status = :cancelled
      @booking.user = @user
      @booking.save!
    end
  end
end
