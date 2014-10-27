class ReverseRouteBuilder
  def initialize(route)
    @route = route
    @reverse_route = Route.new
  end

  def build
    build_reverse_route
    build_reverse_destinations
    build_reverse_connections
    @reverse_route
  end

  private

  def build_reverse_route
    @reverse_route = @route.dup.tap do |route|
      route.name = "Reverse of #{@route.name}"
      route.connections_count = 0
    end
    @reverse_route.save!
  end

  def build_reverse_connections
    @route.connections.each do |c|
      reverse_connection = c.dup
      reverse_connection.to_id =  @reverse_route.destinations.find_by(city: c.from.city).id
      reverse_connection.from_id =  @reverse_route.destinations.find_by(city: c.to.city).id
      @reverse_route.connections.create!(reverse_connection.attributes)
    end
  end

  def build_reverse_destinations
    sequence = 1
    @route.destinations.reverse.each do |d|
      reverse_destination = d.dup
      reverse_destination.sequence = sequence
      @reverse_route.destinations.create!(reverse_destination.attributes)
      sequence += 1
    end
  end
end
