module TripHelper
  class OccupancyItem < Struct.new(:from, :to, :occupied); end

  def display_occupancy(trip)
    items = []
    occupancy = 0
    from_destinations.each_with_index do |destination, index|
      occupancy += calculate_occupancy(destination) if @trip.bookings.any?
      items << OccupancyItem.new(destination.city_name, to_destinations[index].city_name, occupancy)
    end
    render partial: 'trips/occupancy', locals: { capacity: trip.bus_capacity, items: items }
  end

  private

  def calculate_occupancy(destination)
    getting_on_at(destination) - getting_off_at(destination)
  end

  def destinations
    @destinations ||= @trip.route.destinations.to_a.sort_by!(&:sequence)
  end

  def from_destinations
    @from_destinations ||= destinations.dup.tap(&:pop)
  end

  def to_destinations
    @to_destinations ||= destinations.dup.tap(&:shift)
  end

  def bookings
    @bookings ||= @trip.bookings.travelling
  end

  def getting_on_at(destination)
    bookings.joins(stop: :connection).where(connections: { from_id: destination.id }).sum(:quantity)
  end

  def getting_off_at(destination)
    bookings.joins(stop: :connection).where(connections: { to_id: destination.id }).sum(:quantity)
  end
end
