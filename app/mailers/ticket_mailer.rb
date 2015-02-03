class TicketMailer < ActionMailer::Base
  helper :bootstrap, :application

  def send_ticket(booking)
    @ticket = Ticket.new(booking, view_context)
    @settings = Setting.first
    mail to: booking.client_email, cc: @settings.email, from: @settings.email, subject: 'Your Ticket'
  end
end
