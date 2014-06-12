# Updates the seating on the stop by the quantity passed in
class AssignSeating
  include Service

  def initialize(quantity, stop)
    @quantity = quantity
    @stop = stop
    @trip = stop.trip
  end

  def execute
    conditions = "available_seats = available_seats - #{@quantity}"
    affected_stops.update_all(conditions)
    @trip.touch
  end

  private

  def affected_stops
    LocateStops.execute(@trip, @stop)
  end
end
