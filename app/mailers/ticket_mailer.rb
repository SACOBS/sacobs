class TicketMailer < ActionMailer::Base
  helper :bootstrap, :application
  default from: "tickets@sacobs.com"

  def send_ticket(booking)
    @ticket = Ticket.new(booking, view_context)
    @settings = Setting.first
    mail to: booking.client_email, subject: 'Your Ticket'
  end
end
