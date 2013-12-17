class AvailabilityService
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
     destination = find_destination
     affected_destinations = find_affected_destinations(destination)
     related_connections = find_related_connections(destinations)
     find_stops_by_connection(related_connections)
   end

   def find_destination
     @route.destinations.find_by(city: @connection.to_city)
   end

   def find_affected_destinations(destination)
     @route.destinations.where("destination_order < ?", destination.destination_order)
   end

   def find_related_connections(destinations)
     cities = destinations.map(&:city_id)
     @route.connections.where(from_city_id: cities)
   end

   def find_stops_by_connection(connections)
     @trip.stops.where(connection_id: connections) || Stop.none
   end
end