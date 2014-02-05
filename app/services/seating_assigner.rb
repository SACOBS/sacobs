class SeatingAssigner
  def initialize(booking)
    @booking = booking
    @trip = booking.trip
    @stop = booking.stop
  end

  def unassign
    affected_stops.each do |stop|
      stop.increment(:available_seats, @booking.quantity)
      stop.save!
    end
  end

  def assign
    affected_stops.each do |stop|
      stop.decrement(:available_seats, @booking.quantity)
      stop.save!
    end
  end

  private
   def affected_stops
     @trip.stops.en_route(@stop.connection.from).to_a.reject {|stop| stop.connection.from == @stop.connection.to}
   end
end