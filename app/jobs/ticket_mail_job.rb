class TicketMailJob
  include SuckerPunch::Job

  def perform(booking)
    @booking = booking
    TicketMailer.send_ticket(@booking).deliver
  end
end