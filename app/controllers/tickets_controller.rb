class TicketsController < ApplicationController
  before_action :set_booking

  def download
    @ticket = Ticket.new(@booking, view_context, @settings)
    render pdf: "#{@ticket.to_file_name}",
           template: 'tickets/ticket.pdf.erb',
           disposition: :attachment,
           layout: 'application.pdf.erb'
  end

  def show
    @ticket = Ticket.new(@booking, view_context, @settings)
  end

  def print
    @ticket = Ticket.new(@booking, view_context, @settings)
    render pdf: "#{@ticket.to_file_name}",
           template: 'tickets/ticket.pdf.erb',
           layout: 'application.pdf.erb'
  end

  def email
    if @booking.client.email.present?
      TicketMailer.send_ticket(@booking).deliver_later
      redirect_to ticket_url(@booking), notice: 'Ticket has been emailed successfully'
    else
      redirect_to ticket_url(@booking), alert: 'The client for this booking does not have an email to send to. Please update the client email and try again.'
    end
  end

  private
  def set_booking
    @booking = Booking.unscoped { Booking.find(params[:id]) }
  end
end
