class AvailabilityService

  attr_reader :travel_date, :from_city, :to_city, :seats

  def initialize(travel_date ,from, to, seats)
    @travel_date = travel_date
    @from_city = City.find_by(name: from)
    @to_city = City.find_by(name: to)
    @seats = seats
  end

  def check
    trips = Trip.where(start_date: travel_date)
    return Trip.none if trips.empty?
    available_trips = []
    trips.each do |trip|
      departing = from_stop(trip)
      destination = to_stop(trip)
      stops = trip.stops.en_route(departing, destination)
      available_trips << trip unless stops.empty? || stops.any? { |s| s.available_seats < seats }
    end
    available_trips
  end

  def from_stop(trip)
    if from_city
      from_connection = trip.route.connections.find_by(from_city: from_city)
      trip.stops.find_by(connection: from_connection)
    end
  end

  def to_stop(trip)
    if to_city
      to_connection = trip.route.connections.find_by(to_city: to_city)
      trip.stops.find_by(connection: to_connection)
    end
  end
end