class JourneySearch

  attr_reader :results

  def initialize(booking, criteria = {})
    @booking = booking
    @criteria = criteria.reject{|k, v| v =~ /Select/ }
  end

  def results
    stops = Stop.all
    apply_return_filters
    #stops.search(@search_criteria).result(distinct: true).valid
    stops.search(@search_criteria).result(distinct: true)
  end

  private
   def apply_return_filters
     @criteria.merge!(trip_id_in: return_trips) if @booking.has_return
   end

   def return_trips
     Trip.from(@booking.trip.route.end_city).pluck(:id)
   end
end