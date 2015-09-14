class Trip::AssignSeats

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
    stops_to_unassign.update_all(['available_seats = available_seats - ?', quantity])
    trip.touch
  end

  private
  attr_reader :trip, :stop, :quantity

  def stops_to_unassign
    stops.along_the_way(stop.connection.from, stop.connection.to)
  end
end