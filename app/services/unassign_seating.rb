class UnassignSeating
  include Service

  def initialize(quantity, stop)
    @quantity = quantity
    @stop = stop
    @trip = stop.trip
  end

  def execute
    Stop.transaction do
      affected_stops.each do |stop|
        stop.available_seats += @quantity
        stop.save!
      end
    end
  end

  private

  def affected_stops
    StopsEnRoute.new(@trip, @stop).stops
  end
end
