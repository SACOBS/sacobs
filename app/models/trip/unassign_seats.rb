class Trip::UnassignSeats
  def self.perform(*args)
    new(*args).perform
  end

  def initialize(trip, stop, quantity)
    @trip = trip
    @stop = stop
    @quantity = quantity
  end

  def perform
    stops.unassign_seats(quantity)
    trip.touch
  end

  private

  attr_reader :trip, :stop, :quantity

  def stops
    trip.stops.along_the_way(stop.connection.from, stop.connection.to)
  end
end
