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
    l model.trip_start_date, format: :long
  end


  def from
    model.stops.first.from.name
  end

  def from_venue
    model.stops.first.from.city.venues.any? ? model.stops.first.from.city.venues.first.name : 'None'
  end

  def to
    model.stops.last.to.name
  end

  def to_venue
    model.stops.last.to.city.venues.any? ? model.stops.first.to.city.venues.first.name : 'None'
  end

  def status
    model.status.capitalize
  end

  def booking_date
    l model.created_at
  end

  def expiry_date
    l model.expiry_date
  end

  def price
    h.number_to_currency(model.invoice.total, unit: 'R')
  end

  def row_class
   return 'warning' if model.expired?
   case model.status
     when :paid
       'success'
     when :reserved
       'info'
     when :cancelled
       'error'
     else
       ''
   end
 end
end
