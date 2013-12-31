class TicketMailer < ActionMailer::Base
  helper :bootstrap
  default from: "tickets@sacobs.com"

  def send_ticket(booking)
    @booking = booking
    mail to: booking.client.email, subject: 'Your Ticket'
  end
end
