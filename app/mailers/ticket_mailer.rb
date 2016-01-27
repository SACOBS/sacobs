class TicketMailer < ApplicationMailer

  def send_ticket(booking)
    @ticket = Ticket.new(booking, view_context, settings)
    mail to: booking.client.email, cc: settings.email, from: settings.email, subject: 'Your Ticket'
  end
end
