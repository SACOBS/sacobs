class BookingDecorator < Draper::Decorator
  delegate_all
  decorates_association :client
  decorates_association :passengers

  def reference
    model.reference_no.presence || 'None'
  end

  def client_name
    model.client.full_name.capitalize
  end

  def travel_date
    l booking.trip.start_date, format: :long
  end

  def trip_name
    model.trip.name
  end

  def from
    model.stops.first.from_city.name
  end

  def to
    model.stops.first.to_city.name
  end

  def number_of_stops
    model.stops.size
  end

  def status
    model.status.capitalize
  end

  def booking_date
    l model.created_at, format: :long
  end

  def price
    h.number_to_currency(model.invoice.total, unit: 'R')
  end
end
