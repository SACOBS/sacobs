class StopDecorator < BaseDecorator
  def arrive_time
    format_time(arrive)
  end

  def depart_time
    format_time(depart)
  end

  def occupied
    trip.bus_capacity - available_seats
  end

  private

  def format_time(time)
    time.strftime('%H:%M%p')
  end
end
