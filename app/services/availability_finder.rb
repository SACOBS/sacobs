class AvailabilityFinder

  attr_reader :trip, :from_city, :to_city


  def initialize(trip ,from_city, to_city)
    @trip = trip
    @from_city = from_city
    @to_city = to_city
  end

  def check
    from = from_stop
    to = to_stop
    available_stops = find_stops(from, to)
  end


  def from_stop
    from_connection = find_connection(from_city: from_city)
    find_stop(connection: from_connection)
  end

  def to_stop
    to_connection = find_connection(to_city: to_city)
    find_stop(connection: to_connection)
  end


  def find_stops(from, to)
   stops = trip.stops.en_route(from, to)
   return Stop.none if stops.any? { |s| s.available_seats.zero? }
   stops
  end

  def find_connection(arg)
    trip.route.connections.find_by(arg)
  end

  def find_stop(arg)
    trip.stops.find_by(arg)
  end

end