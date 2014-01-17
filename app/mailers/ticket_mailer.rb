class TicketMailer < ActionMailer::Base
  helper :bootstrap
  default from: "tickets@sacobs.com"

  def send_ticket(booking)
    @ticket = Ticket.new(booking)
    mail to: booking.client.email, subject: 'Your Ticket'
  end
end
