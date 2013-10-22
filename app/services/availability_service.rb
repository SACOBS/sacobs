class AvailabilityService

  attr_reader :travel_date, :from_city, :to_city, :seats

  def initialize(*args)
    options = args.extract_options!
    @travel_date = Date.parse(options[:travel_date])
    @from_city = find_city(options[:from])
    @to_city = find_city(options[:to])
    @seats = options[:seats].to_i
  end

  def check
    trips = Trip.where(start_date: travel_date)
    return Trip.none if trips.empty?
    available_trips = []
    trips.each do |trip|
      departing = trip.stops.departing(from_city).first
      destination = trip.stops.destination(to_city).first
      stops = trip.stops.en_route(departing, destination)
      available_trips << trip unless stops.empty? || stops.any? { |s| s.available_seats < seats }
    end
    available_trips
  end

  private
  def find_city(id)
    City.find(id)
  end
end