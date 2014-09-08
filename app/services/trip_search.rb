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
     criteria.merge!(connection_from_city_id_eq: fetch_city(@search_params[:from_city]).id) if @search_params.has_key?(:from_city)
     criteria.merge!(connection_to_city_id_eq: fetch_city(@search_params[:to_city]).id) if @search_params.has_key?(:to_city)
     criteria
   end

   def fetch_city(name)
     City.find_by(name: name)
   end
end
