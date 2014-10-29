# Updates the seating on the stop by the quantity passed in
class AssignSeating
  include Service

  def initialize(quantity, stop)
    @quantity = quantity
    @stop = stop
    @trip = stop.trip
  end

  def execute
    affected_stops.all?
    Stop.transaction do
      affected_stops.each do |stop|
        number_seats = stop.available_seats - @quantity
        number_seats = 0 if number_seats < 0
        stop.available_seats = number_seats
        stop.save!
      end
    end
  end

  private

  def affected_stops
    @affected_stops ||= StopsEnRoute.new(@trip, @stop).stops
  end
end
