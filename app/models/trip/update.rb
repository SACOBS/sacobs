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
      raise ActiveRecord::Rollback unless trip.save && create_stops
    end
    trip
  end

  private

  def create_stops
    if trip.route_id_changed?
      stops.clear
      stops.create(route.connections.map { |connection| { connection: connection, available_seats: bus.capacity } })
    end
    stops.all?(&:persisted?)
  end

end