class LocateStops
  include Service

  def initialize(trip, stop)
    @trip = trip
    @stop = stop
  end

  def execute
    @trip.stops.en_route(@stop.connection.from).joins(:connection).where.not(connections: { from_id: @stop.connection.to })
  end
end
