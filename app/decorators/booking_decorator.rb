class BookingDecorator < Draper::Decorator
  delegate_all
  decorates_association :main
  decorates_association :return_booking
  decorates_association :client
  decorates_association :passengers
  decorates_association :stop

  def reference
    model.reference_no.presence || 'None'
  end

  def client_name
    model.client_full_name.capitalize if model.client
  end

  def travel_date
    model.trip_start_date
  end

  def from
    stop.from
  end

  def from_venue
   stop.connection.from_city.venues.any? ? stop.connection.from_city.venues.first.name : 'None'
  end

  def to
    stop.to
  end

  def to_venue
    stop.connection.to_city.venues.any? ? stop.connection.to_city.venues.first.name : 'None'
  end

  def status
    model.status.capitalize
  end

  def booking_date
    model.created_at
  end


  def expires_in
    h.distance_of_time_in_words_to_now(expiry_date)
  end

  def price
    h.number_to_currency(model.invoice_total, unit: 'R')
  end

  def payment_date
    payment_detail.payment_date if payment_detail
  end

  def payment_type
    payment_detail.payment_type_description if payment_detail
  end

  def payment_reference
   payment_detail.reference.presence || 'None' if payment_detail
  end

  def row_class
   return 'warning' if expired?
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
