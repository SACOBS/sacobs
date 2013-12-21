class BookingService
  def initialize(opts={})
    @trip = Trip.find(opts.fetch(:id))
    @connection = Connection.find(opts.fetch(:connection))
    @quantity = opts.fetch(:seats).to_i
    @stop = @trip.stops.find_by(connection: @connection)
  end


  def create_booking!
   @trip.bookings.create!(quantity: @quantity, stops: [@stop], expiry_date: booking_expiry, return: false)
  end

  def available_seats
    @stop.available_seats
  end

  def seats_available?
    @stop.available_seats >= @quantity
  end

  private
   def find_trip(id)
     Trip.find(id)
   end

   def find_connection(id)
     Connection.find(id)
   end

   def booking_expiry
     Time.zone.now + (Setting.to_hash['booking_expiry_period'].to_i).hours
   end
end