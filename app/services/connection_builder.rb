# Builds connections for a route from the destinations
class ConnectionBuilder
  def initialize(route)
    @route = route
    @destinations = route.destinations.to_a
  end

  def build
    Route.transaction do
      @destinations.each { |destination| generate_connections(destination) }
    end
  end

  private

  def generate_connections(current)
    available_destinations = @destinations.dup.tap { |ad| ad.shift(current.sequence) }
    available_destinations.each do |destination|
      @route.connections.includes(:from, :to).find_or_create_by(from_id: current.id, to_id: destination.id) do |connection|
        connection.name = "#{current.city_name} to #{destination.city_name}"
      end
    end
  end
end
