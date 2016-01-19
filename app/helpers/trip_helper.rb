module TripHelper
  def display_occupancy(trip)
    items = trip.occupancy
    render partial: "trips/occupancy.html.erb", locals: {capacity: trip.bus.capacity, items: items}
  end
end
