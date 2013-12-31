class SeatingService
  def initialize(trip, connection)
    @trip = trip
    @route = trip.route
    @connection = connection
  end

  def increment_seating(quantity)
    affected_stops.each do |stop|
      stop.available_seats += quantity
      stop.save!
    end
  end

  def decrement_seating(quantity)
    affected_stops.each do |stop|
      stop.available_seats -= quantity
      stop.save!
    end
  end

  private
   def affected_stops
     destination = @connection.to_destination
     affected_destinations = find_affected_destinations(destination)
     related_connections = find_related_connections(affected_destinations)
     find_stops_by_connection(related_connections)
   end

   def find_affected_destinations(destination)
     @route.destinations.preceding(destination.destination_order).pluck(:id)
   end

   def find_related_connections(destinations)
     @route.connections.where(from_destination_id: destinations).pluck(:id)
   end

   def find_stops_by_connection(connections)
     @trip.stops.where(connection_id: connections) || Stop.none
   end
end