class AssignSeating
  def initialize(trip, connection)
    @trip = trip
    @route = trip.route
    @connection = connection
  end

  def increment(quantity)
    affected_stops.each { |stop| stop.increment!(:available_seats, quantity) }
  end

  def decrement(quantity)
    affected_stops.each { |stop| stop.decrement!(:available_seats, quantity) }
  end

  private
    def affected_stops
      @trip.stops.en_route(@route, @connection.to_destination.destination_order).readonly(false)
    end
end