class Booking::Reserve
  def initialize(booking, settings)
    @booking = booking
    @return_booking = booking.return_booking
    @trip = booking.trip
    @stop = booking.stop
    @settings = settings
  end

  def perform
    Booking.transaction do
      [booking, return_booking].compact.each do |booking|
        unless booking.reserved?
          assign_seats(booking.trip, booking.stop, booking.quantity)
          booking.expiry_date = settings.booking_expiry_period.hours.from_now
          booking.update!(status: :reserved)
        end
      end
    end
  end

  private
  attr_reader :booking, :return_booking, :settings

  def assign_seats(trip, stop, qty)
    trip.assign_seats(stop, qty)
  end
end