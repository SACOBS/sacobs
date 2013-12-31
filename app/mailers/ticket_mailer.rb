class TicketMailer < ActionMailer::Base
  helper :bootstrap
  default from: "tickets@sacobs.com"

  def send_ticket(booking)
    @booking = booking
    mail to: 'paul@searleconsulting.co.za', subject: 'Your Ticket'
  end
end
