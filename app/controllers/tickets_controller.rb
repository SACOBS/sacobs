class TicketsController < ApplicationController
  before_action :set_booking

  def download
    @ticket = Ticket.new(@booking, view_context)
    render_pdf(disposition: :attachment)
  end

  def show
    @ticket = Ticket.new(@booking, view_context)
  end

  def print
    @ticket = Ticket.new(@booking, view_context)
    render_pdf
  end

  def email
    TicketMailer.send_ticket(@booking).deliver_later
    respond_with @booking, location: ticket_url(@booking), notice: 'Ticket has been emailed successfully'
  end

  private

  def render_pdf(disposition: :inline)
    render pdf: "#{@ticket.to_file_name}",
           template: 'tickets/_ticket.html.haml',
           disposition: disposition,
           layout: 'pdf.html',
           locals: { ticket: @ticket }
  end

  def set_booking
    @booking = Booking.unscoped { Booking.find(params[:id]) }
  end
end
