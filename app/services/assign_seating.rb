class AssignSeating
  include Service

  def initialize(quantity, stop)
    @quantity = quantity
    @stop = stop
    @trip = stop.trip
  end

  def execute
    affected_stops.update_all("available_seats = available_seats - #{@quantity}")
    @trip.touch
  end

  private
  def affected_stops
    LocateStops.execute(@trip, @stop)
  end
end