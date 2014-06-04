class ReturnTripSearch
  include Service

  def initialize(trip, qty_seats, criteria)
    @criteria = criteria.reject{|k, v| v =~ /Select/ }
    @trip = trip
    @qty_seats = qty_seats
  end

  def execute
    @criteria.merge!(trip_id_in: return_trips, available_seats_gteq: @qty_seats)
    Stop.search(@criteria).result(distinct: true).valid.limit(30)
  end

  private
   def return_trips
    Trip.from_location(@trip.route.end_city).pluck(:id)
   end


end