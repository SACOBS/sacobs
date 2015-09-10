class Route::Copy
  def self.perform(*args)
    new(*args).perform
  end

  def initialize(route, user)
    @route = route
    @user = user
  end

  def perform
    copy = route.dup
    copy.name = "Copy of #{route.name}"
    copy.user_id = user.id
    route.destinations.each { |destination| copy.destinations.build(city: destination.city, sequence: destination.sequence) }
    route.connections.each do |connection|
      from_destination = copy.destinations.find { |destination| destination.city == connection.from.city  }
      to_destination = copy.destinations.find { |destination| destination.city == connection.to.city }
      copy.connections.build(from: from_destination, to: to_destination, cost: connection.cost, percentage: connection.percentage, distance: connection.distance, leaving: connection.leaving, arriving: connection.arriving)
    end
    copy
  end

  private
  attr_reader :route, :user
end
