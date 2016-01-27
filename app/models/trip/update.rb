class Trip::Update
  attr_reader :trip

  delegate :bus, :route, :stops, to: :trip

  def self.perform(*args)
    new(*args).perform
  end

  def initialize(trip, params)
    @trip = trip
    @trip.assign_attributes(params)
  end

  def perform
    Trip.transaction do
      fail ActiveRecord::Rollback unless trip.save && create_stops
    end
    trip
  end

  private

  def create_stops
    if route_changed?
      stops.clear
      stops.create(route.connections.map { |connection| { connection: connection, available_seats: bus.capacity } })
    end
    stops.all?(&:persisted?)
  end

  def route_changed?
    trip.route_id_changed?
  end
end
