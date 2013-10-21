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
      departing = trip.stops.from(from_city).first
      destination = trip.stops.to(to_city).first
      stops = trip.stops.en_route(departing, destination)
      available_trips << trip unless stops.empty? || stops.any? { |s| s.available_seats < seats }
    end
    available_trips
  end
end