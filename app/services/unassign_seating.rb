class UnassignSeating
  include Service

  def initialize(quantity, stop)
    @quantity = quantity
    @stop = stop
    @trip = stop.trip
    @capacity = @trip.bus_capacity
  end

  def execute
    Trip.no_touching do
      Stop.transaction do
        affected_stops.each do |stop|
          stop.available_seats = calculate_available_seating(stop.available_seats)
          stop.save!
        end
      end
    end
    @trip.touch
  end

  private

  def calculate_available_seating(current)
    number_seats = current + @quantity
    number_seats = @capacity if number_seats > @capacity
    number_seats
  end

  def affected_stops
    StopsEnRoute.new(@trip, @stop).stops
  end
end
