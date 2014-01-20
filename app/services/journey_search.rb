class JourneySearch

  attr_reader :results

  def initialize(booking ,search_criteria = {})
    @booking = booking
    @search_criteria = search_criteria.reject!{|k, v| v =~ /Select/ } || {}
  end

  def results
    stops = Stop.all
    @search_criteria.merge!(trip_id_in: return_trips) if @booking.has_return
    stops.search(@search_criteria).result(distinct: true)
  end

  private
   def return_trips
     Trip.from(@booking.trip.route.end_city).pluck(:id)
   end



end