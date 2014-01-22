class SeatingAssigner
  def initialize(booking)
    @booking = booking
    @trip = booking.trip
    @stop = booking.stops.first
  end

  def unassign
    return unless @booking.trip && @booking.stops.any?
    affected_stops.each { |stop| stop.increment!(:available_seats, @booking.quantity) }
  end

  def assign
    return unless @booking.trip && @booking.stops.any?
    affected_stops.each { |stop| stop.decrement!(:available_seats, @booking.quantity) }
  end


  private
   def affected_stops
     @trip.stops.en_route(@stop.connection.from).to_a.reject {|stop| stop.connection.to == @stop.connection.from}
   end
end