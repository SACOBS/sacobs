class Trip::UnassignSeats

  delegate :stops, to: :trip

  def self.perform(*args)
    new(*args).perform
  end

  def initialize(trip, stop, quantity)
    @trip = trip
    @stop = stop
    @quantity = quantity
  end

  def perform
    stops_to_assign.update_all(['available_seats = available_seats + ?', quantity])
    trip.touch
  end

  private
  attr_reader :trip, :stop, :quantity

  def stops_to_assign
    stops.joins(connection: :to).where('connections.from_id != ? and destinations.sequence > ?', stop.connection.to, stop.connection.from.sequence)
  end
end