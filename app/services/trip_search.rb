# Searches for stops based on specific criteria
class TripSearch
  include Service


  def initialize(search_params)
    @search_params = search_params
  end

  def execute
    Stop.search(criteria_from_params).result(distinct: true).valid.limit(30)
  end

  private
   def criteria_from_params
     criteria = {}
     criteria.merge!(trip_start_date_eq: @search_params[:trip_date]) if @search_params.has_key?(:trip_date)
     criteria.merge!(connection_from_city_id_eq: @search_params[:from_city_id]) if @search_params.has_key?(:from_city_id)
     criteria.merge!(connection_to_city_id_eq: @search_params[:to_city_id]) if @search_params.has_key?(:to_city_id)
     criteria
   end
end
