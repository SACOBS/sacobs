class OccupancyCell < Cell::Rails

  def show(args)
    trip = args[:trip]
    @capacity = trip.bus_capacity
    @items = OccupancyGraph.execute(trip)
    render
  end

end
