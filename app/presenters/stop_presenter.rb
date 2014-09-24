class StopPresenter
  attr_reader :stop

  delegate :available_seats, :from_city_name, :to_city_name, to: :stop

  def initialize(stop, view_context)
    @stop = stop
    @view_context = view_context
  end

  def arrive_time
    stop.arrive.strftime("%H:%M%p")
  end

  def depart_time
    stop.depart.strftime("%H:%M%p")
  end
end