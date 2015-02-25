class ReturnTripSearch
  include Service

  def initialize(stop, qty_seats, search_params)
    @search_params = search_params
    @stop = stop
    @qty_seats = qty_seats
    init_search_params
  end

  def execute
    Stop.includes(:trip, connection: [from: :city, to: :city]).search(criteria).result(distinct: true).limit(30)
  end

  private

  def init_search_params
    @search_params.merge!(trip_start_date_gteq: @stop.trip_start_date) unless @search_params.key?(:trip_date)
    @search_params.merge!(from_city_id: @stop.to_city_id) unless @search_params.key?(:from_city_id)
    @search_params.merge!(to_city_id: @stop.from_city_id) unless @search_params.key?(:to_city_id)
  end

  def criteria
    criteria = {}
    criteria.merge!(available_seats_gteq: @qty_seats)
    criteria.merge!(trip_start_date_eq: @search_params[:trip_date]) if @search_params.key?(:trip_date)
    criteria.merge!(connection_from_city_id_eq: @search_params[:from_city_id]) if @search_params.key?(:from_city_id)
    criteria.merge!(connection_to_city_id_eq: @search_params[:to_city_id]) if @search_params.key?(:to_city_id)
    criteria
  end
end
