class Bookings::IndexPresenter
  attr_reader :bookings

  def initialize(bookings)
    @bookings = bookings
  end

  def reserved_booking_count
    @reserved_booking_count ||= available_bookings.open.count
  end

  def standby_booking_count
    @standby_booking_count ||= available_bookings.standby.count
  end

  def paid_booking_count
    @paid_booking_count ||= available_bookings.paid.count
  end

  def cancelled_booking_count
    @cancelled_booking_count ||= available_bookings.cancelled.count
  end

  private
  def available_bookings
    @available_bookings ||= Booking.available
  end
end