# Cancels a booking
class CancelBooking
  include Service

  def initialize(booking)
    @booking = booking
  end

  def execute
    Booking.transaction do
      UnassignSeating.execute(@booking.quantity, @booking.stop)
      @booking.status = :cancelled
      @booking.save!
    end
  rescue StandardError => error
    Rails.logger.error error.inspect
    nil
  end
end
