class TripPresenter

  delegate :name, :route_name, :start_date, :end_date, :notes, :bus_name, :created_at, to: :trip

  attr_reader :trip
  def initialize(trip, view_context)
    @trip  = trip
    @view_context = view_context
  end

  def trip_day
    trip.start_date.strftime('%A')
  end

  def bookings_count
    trip.bookings.size
  end


end