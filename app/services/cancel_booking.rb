# Cancels a booking
class CancelBooking
  include Service

  def initialize(booking)
    @booking = booking
  end

  def execute
    Booking.transaction do
      @booking.trip.unassign_seats(@booking.stop, @booking.quantity)
      @booking.status = :cancelled
      @booking.save!
    end
  rescue StandardError => error
    Rails.logger.error error.inspect
    nil
  end
end
