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
     available_destinations = @destinations.dup.tap {|ad| ad.shift(current.destination_order)}
     available_destinations.each { |destination|  @route.connections.create!(from_destination: current, to_destination: destination) }
   end
end