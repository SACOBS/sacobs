class BookingBuilder
  def initialize(date, from, to, return_date, return_city)
    @date = date
    @from = from
    @to = to
    @return_date = return_date
    @return_city = return_city
  end

  def build
    @outgoing_trips = Trip.where(start_date: date).available_stops(@from, @to)

  end
end