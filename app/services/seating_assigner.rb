class SeatingAssigner
  def initialize(booking)
    @booking = booking
    @trip = booking.trip
    @stop = booking.stops.first
  end


  def unassign
    affected_stops.each { |stop| stop.increment!(:available_seats, @booking.quantity) }
  end

  def assign
    affected_stops.each { |stop| stop.decrement!(:available_seats, @booking.quantity) }
  end

  private
   def affected_stops
    @trip.stops.en_route(@trip.route, @stop.connection.to_destination.destination_order).select(:*)
   end
end