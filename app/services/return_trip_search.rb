class ReturnTripSearch
  include Service

  def initialize(stop, qty_seats, search_params)
    @search_params = search_params
    @stop = stop
    @qty_seats = qty_seats
  end

  def execute
      return Stop.none unless return_trips.any?
      criteria_from_params.merge!(trip_id_in: return_trips, available_seats_gteq: @qty_seats, trip_start_date_gt: @stop.trip.start_date)
      Stop.search(criteria_from_params).result(distinct: true).valid.limit(30)
  end

  private
    def return_trips
      Trip.valid.joins(:route).where(route: (return_routes)).pluck(:id)
    end

    def return_routes
      Route.joins(:connections).where(connections: {from_id: @stop.to, to_id: @stop.from }).references(:connections)
    end

    def criteria_from_params
      criteria = {}
      criteria.merge!(trip_start_date_eq: @search_params[:trip_date]) if @search_params.has_key?(:trip_date)
      criteria.merge!(connection_from_city_id_eq: fetch_city(@search_params[:from_city]).id) if @search_params.has_key?(:from_city)
      criteria.merge!(connection_to_city_id_eq: fetch_city(@search_params[:to_city]).id) if @search_params.has_key?(:to_city)
      criteria
    end

    def fetch_city(name)
      City.find_by(name: name)
    end
end
