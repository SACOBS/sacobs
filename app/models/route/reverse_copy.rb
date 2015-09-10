class Route::ReverseCopy
  def self.perform(*args)
    new(*args).perform
  end

  def initialize(route, user)
    @route = route
    @user = user
  end

  def perform
    copy = route.dup
    copy.name = "Reverse of #{route.name}"
    copy.user_id = user.id
    route.destinations.reverse.each_with_index { |destination, index| copy.destinations.build(city: destination.city, sequence: index) }
    route.connections.reverse_each do |connection|
      from_destination = copy.destinations.find { |destination| destination.city == connection.to.city  }
      to_destination = copy.destinations.find { |destination| destination.city == connection.from.city }
      copy.connections.build(from: from_destination, to: to_destination, cost: connection.cost, percentage: connection.percentage, distance: connection.distance, leaving: connection.leaving, arriving: connection.arriving)
    end
    copy
  end

  private
  attr_reader :route, :user
end
