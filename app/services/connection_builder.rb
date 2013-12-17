class ConnectionBuilder

  def initialize(route)
    @route = route
    @destinations = route.destinations.to_a
  end

  def build
    @destinations.each do |destination|
      generate_connections(destination)
    end
  end

  private
   def generate_connections(current)
     available_destinations = @destinations.dup.tap {|ad| ad.shift(current.destination_order)}
     available_destinations.each { |destination|  @route.connections.create!(from_city: current.city, to_city: destination.city) }
   end


end