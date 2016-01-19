class Route::Copy
  def self.perform(*args)
    new(*args).perform
  end

  def initialize(route, user)
    @copy = route.dup
    @route = route
    @user = user
  end

  def perform
    copy.name = "Copy of #{route.name}"
    copy.user_id = user.id
    copy.connections_count = 0
    copy.connections << route.connections.map do |connection|
      connection.dup.tap do |duplicate|
        duplicate.from = find_or_initialize_destination(connection.from.city, connection.from.sequence)
        duplicate.to = find_or_initialize_destination(connection.to.city, connection.to.sequence)
      end
    end
    copy
  end

  private

  attr_reader :copy, :route, :user

  def find_or_initialize_destination(city, sequence)
    copy.destinations.find {|destination| destination.city == city } || copy.destinations.build(city: city, sequence: sequence)
  end
end
