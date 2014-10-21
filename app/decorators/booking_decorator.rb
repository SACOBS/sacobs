class BookingDecorator < BaseDecorator
  def passengers
    @passengers ||= model.passengers.map { |passenger| PassengerDecorator.decorate(passenger, @view_context) }
  end

  def client
    @client ||= ClientDecorator.decorate(model.client, @view_context)
  end

  def return_booking
    @return_booking ||= BookingDecorator.decorate(model.return_booking, @view_context)
  end

  def price
    helpers.number_to_currency(invoice_total)
  end

  def status
    model.status.capitalize
  end

  def trip_date
    helpers.l(trip_start_date, format: :long)
  end

  def expiry_date
    helpers.l(model.expiry_date,format: :short)
  end

  def reference_no
    model.reference_no.presence || 'None'
  end

  def from_city
    stop.from_city_name
  end

  def to_city
    stop.to_city_name
  end

  def payment_date
    helpers.l(payment_detail_payment_date, format: :long)
  end

  def show_link(options = {})
    helpers.link_to 'Show', model, options
  end

  def ticket_link(options = {})
    options.merge!(target: '_blank')
    helpers.link_to('Generate Ticket', helpers.ticket_path(model), options) if paid? || reserved?
  end

  def cancellation_link(options = {})
    options.merge!(method: :patch)
    helpers.link_to('Cancel', helpers.cancel_booking_path(model), options) unless cancelled?
  end

  def confirmation_link(options = {})
    options.merge!(method: :patch)
    helpers.link_to('Confirm', helpers.confirm_booking_path(model), options) if reserved?
  end

  def destroy_link(options = {})
    options.merge!(method: :delete, data: { confirm: helpers.t('messages.confirm', resource: :booking) })
    helpers.link_to('Destroy', model, options) if cancelled?
  end
end
