class TicketsController < ApplicationController
  before_action :set_bookings

  def download
    @ticket = Ticket.new(@booking, view_context, settings)
    render pdf:         @ticket.to_file_name.to_s,
           template:    'tickets/ticket.pdf.erb',
           disposition: :attachment,
           layout:      'application.pdf.erb'
  end

  def print
    @ticket = Ticket.new(@booking, view_context, settings)
    render pdf:      @ticket.to_file_name.to_s,
           template: 'tickets/ticket.pdf.erb',
           layout:   'application.pdf.erb'
  end

  def email
    TicketMailer.send_ticket(@booking).deliver_later
    redirect_to ticket_url(@booking), notice: 'Ticket has been emailed successfully'
  end

  private

  def set_bookings
    @booking = Booking.find(params[:id]).tap { |booking| booking.main || booking }
    @return_booking = @booking.return_booking
  end
end
