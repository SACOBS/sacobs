class Trip::Occupancy
  class Item < Struct.new(:from, :to, :occupied); end

  def initialize(trip)
    @trip = trip
  end

  def statistics
    items = []
    occupancy = 0
    from_destinations.each_with_index do |destination, index|
      occupancy += calculate_occupancy(destination) if trip.bookings.any?
      items << Item.new(destination.city_name, to_destinations[index].city_name, occupancy)
    end
    items
  end

  private
  attr_reader :trip

  def calculate_occupancy(destination)
    getting_on_at(destination) - getting_off_at(destination)
  end

  def destinations
    @destinations ||= trip.route.destinations.to_a.sort_by!(&:sequence)
  end

  def from_destinations
    @from_destinations ||= destinations.dup.tap(&:pop)
  end

  def to_destinations
    @to_destinations ||= destinations.dup.tap(&:shift)
  end

  def bookings
    @bookings ||= trip.bookings.travelling
  end

  def getting_on_at(destination)
    bookings.joins(stop: :connection).where(connections: { from_id: destination.id }).sum(:quantity)
  end

  def getting_off_at(destination)
    bookings.joins(stop: :connection).where(connections: { to_id: destination.id }).sum(:quantity)
  end
end