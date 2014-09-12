class ReturnTripSearch
  include Service

  def initialize(stop, qty_seats, search_params)
    @search_params = search_params
    @stop = stop
    @qty_seats = qty_seats
    init_search_params
  end

  def execute
    Stop.search(criteria).result(distinct: true).valid.limit(30)
  end

  private
    def init_search_params
      @search_params.merge!(from_city_id: @stop.to.city_id) unless @search_params.has_key?(:from_city_id)
      @search_params.merge!(to_city_id: @stop.from.city_id) unless @search_params.has_key?(:to_city_id)
    end

    def criteria
      criteria = {}
      criteria.merge!(available_seats_gteq: @qty_seats)
      criteria.merge!(trip_start_date_eq: @search_params[:trip_date]) if @search_params.has_key?(:trip_date)
      criteria.merge!(connection_from_city_id_eq: @search_params[:from_city_id]) if @search_params.has_key?(:from_city_id)
      criteria.merge!(connection_to_city_id_eq: @search_params[:to_city_id]) if @search_params.has_key?(:to_city_id)
      criteria
    end
end
