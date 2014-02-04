class ConnectionBuilder

  def initialize(route)
    @route = route
    @destinations = route.destinations.to_a
  end

  def build
    @destinations.each { |destination| generate_connections(destination) }
  end

  private
   def generate_connections(current)
     available_destinations = @destinations.dup.tap {|ad| ad.shift(current.sequence)}
     available_destinations.each { |destination|  @route.connections.find_or_initialize_by(from_id: current.id, to_id: destination.id) }
   end
end