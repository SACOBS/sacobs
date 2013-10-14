class TripService

  attr_reader :trip

  def initialize(trip)
    @trip = trip
  end

  def create(attributes)
    trip.assign_attributes(attributes)
    build_stops
    save
  end

  def update(attributes)
    trip.assign_attributes(attributes)
    if trip.route_id_changed?
      trip.stops.destroy_all
      build_stops
    end
    save
  end

  private
  def build_stops
    trip.route.connections.each { |connection| trip.stops.build(connection: connection, available_seats: trip.bus.capacity) }
  end

  def save
    trip.save
    trip
  end
end