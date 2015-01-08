# Builds connections for a route from the destinations
class ConnectionBuilder
  def initialize(route)
    @route = route
    @destinations = route.destinations.order(:sequence)
  end

  def build
    Route.transaction do
      @destinations.each { |destination| generate_connections(destination) }
      @route.save
    end
  end

  private

  def generate_connections(current)
    available_destinations = @destinations.to_a.dup.tap { |ad| ad.shift(current.sequence) }
    available_destinations.each do |destination|
      unless @route.connections.exists?(from_id: current.id, to_id: destination.id)
        @route.connections.build(from_id: current.id, to_id: destination.id) do |connection|
          connection.name = "#{current.city_name} to #{destination.city_name}"
        end
      end
    end
  end
end
