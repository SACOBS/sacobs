class Trip::Create
  attr_reader :trip

  delegate :bus, :route, :stops, to: :trip

  def self.perform(*args)
    new(*args).perform
  end

  def initialize(params)
    @trip = Trip.new
    @trip.assign_attributes(params)
  end

  def perform
    Trip.transaction do
      trip.name ||= route.name
      raise ActiveRecord::Rollback unless trip.save && create_stops
    end
    trip
  end

  private

  def create_stops
    stops.create(route.connections.map { |connection| { connection: connection, available_seats: bus.capacity } })
    stops.all?(&:persisted?)
  end
end