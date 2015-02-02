class TicketMailer < ActionMailer::Base
  helper :bootstrap, :application
  default from: 'info@saconnection.co.za'

  def send_ticket(booking)
    @ticket = Ticket.new(booking, view_context)
    @settings = Setting.first
    mail to: booking.client_email, cc: 'info@saconnection.co.za', subject: 'Your Ticket'
  end
end
