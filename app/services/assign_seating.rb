# Updates the seating on the stop by the quantity passed in
class AssignSeating
  include Service

  def initialize(quantity, stop)
    @quantity = quantity
    @stop = stop
    @trip = stop.trip
  end

  def execute
    Stop.transaction do
      affected_stops.each do |stop|
        stop.available_seats = calculate_available_seating(stop.available_seats)
        stop.save!
      end
    end
  end

  private

  def calculate_available_seating(current)
    number_seats = current - @quantity
    number_seats = 0 if number_seats < 0
    number_seats
  end

  def affected_stops
    @affected_stops ||= StopsEnRoute.new(@trip, @stop).stops
  end
end
