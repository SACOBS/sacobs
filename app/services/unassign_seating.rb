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
        affected_stops.update_all("available_seats = available_seats + #{@quantity}")
      end
    end
    @trip.touch
  end

  private
  def affected_stops
    StopsEnRoute.new(@trip, @stop).stops
  end
end
