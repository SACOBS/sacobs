class BookingService
  def initialize(opts={})
    @trip = Trip.find(opts.fetch(:id))
    @stop = Stop.find(opts.fetch(:stop))
    @quantity = opts.fetch(:seats).to_i
  end

  def create_booking!
   @trip.bookings.create!(quantity: @quantity, stops: [@stop], expiry_date: booking_expiry)
  end

  def available_seats
    @stop.available_seats
  end

  def seats_available?
    @stop.available_seats >= @quantity
  end

  private
   def booking_expiry
     Time.zone.now + (Setting.to_hash['booking_expiry_period'].to_i).hours
   end
end