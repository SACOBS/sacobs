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
    copy.connections << dup_connections
    copy
  end

  private

  attr_reader :copy, :route, :user

  def dup_connections
    route.connections.map { |connection| dup_connection(connection) }
  end

  def dup_connection(connection)
    connection.dup.tap do |duplicate|
      duplicate.from = find_or_initialize_destination(connection.from.city, connection.from.sequence)
      duplicate.to = find_or_initialize_destination(connection.to.city, connection.to.sequence)
    end
  end

  def find_or_initialize_destination(city, sequence)
    find_copy_destination(city) || build_destination(city, sequence)
  end

  def find_destination(city)
    copy.destinations.select { |destination| destination.city == city }
  end

  def build_destination(city, sequence)
    copy.destinations.build(city: city, sequence: sequence)
  end
end
