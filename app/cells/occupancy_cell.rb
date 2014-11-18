class OccupancyCell < Cell::Rails
  cache :show do |options|
    [options[:trip].updated_at, options[:trip].bookings.size]
  end

  def show(args)
    trip = args[:trip]
    @capacity = trip.bus_capacity
    @items = OccupancyGraph.execute(trip)
    render
  end
end
