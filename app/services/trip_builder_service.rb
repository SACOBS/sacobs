class TripBuilderService

  attr_reader :trip

  def initialize(trip)
    @trip = trip
  end

  def build
    route = trip.route
    bus = trip.bus
    route.connections.each { |connection| trip.stops.build(connection: connection, available_seats: bus.capacity) }
    trip.save
  end
end