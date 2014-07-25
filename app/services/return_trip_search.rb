class ReturnTripSearch
  include Service

  def initialize(stop, qty_seats, criteria)
    @criteria = criteria.reject { |_k, v| v =~ /Select/ }
    @stop = stop
    @qty_seats = qty_seats
  end

  def execute
    @criteria.merge!(trip_id_in: return_trips, available_seats_gteq: @qty_seats)
    Stop.search(@criteria).result(distinct: true).valid.limit(30)
  end

  private
  def return_trips
    routes = Route.joins(:connections).where(connections: {from_id: @stop.to, to_id: @stop.from }).references(:connections)
    Trip.valid.joins(:route).where(route: (routes)).pluck(:id)
  end
end
