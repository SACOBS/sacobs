class BookingDecorator < Draper::Decorator
  delegate_all
  decorates_association :client
  decorates_association :passengers

  def reference
    model.reference_no.presence || 'None'
  end

  def client_name
    model.client.full_name.capitalize if model.client
  end

  def travel_date
    l booking.trip.start_date, format: :long if model.trip
  end

  def trip_name
    model.trip.name if model.trip
  end

  def from
    model.stops.first.from_city.name
  end

  def from_venue
    model.stops.first.from_city.venues.any? ? model.stops.first.from_city.venues.first.name : 'None'
  end

  def to
    model.stops.last.to_city.name
  end

  def to_venue
    model.stops.last.to_city.venues.any? ? model.stops.first.from_city.venues.first.name : 'None'
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
