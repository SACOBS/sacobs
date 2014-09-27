class BookingDecorator < BaseDecorator
   def passengers
     @passengers ||= model.passengers.map {|passenger| PassengerDecorator.decorate(passenger, @view_context)}
   end

   def client
    @client ||= ClientDecorator.decorate(model.client, @view_context)
   end

   def expires_in
     helpers.time_ago_in_words(expiry_date)
   end

   def price
     helpers.number_to_currency(invoice_total, unit: 'R')
   end

   def status
     model.status.capitalize
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

   def show_link(options={})
     helpers.link_to 'Show', model, options
   end

   def copy_link(options={})

   end

   def ticket_link(options={})
     options.merge!(target: '_blank')
     helpers.link_to('Generate Ticket', helpers.ticket_path(model), options) if paid?
   end

   def cancellation_link(options={})
     options.merge!(method: :patch)
    helpers.link_to('Cancel', helpers.cancel_booking_path(model), options) unless cancelled?
   end

   def confirmation_link(options={})
     options.merge!(method: :patch)
     helpers.link_to('Confirm', helpers.confirm_booking_path(model), options) if reserved?
   end

   def destroy_link(options={})
     options.merge!(method: :delete, data: { confirm: helpers.t('messages.confirm', resource: :booking) })
     helpers.link_to('Destroy', model, options) if cancelled?
   end
end