class TicketsController < ApplicationController
  before_action :set_booking

  def download
    pdf = generate_pdf
    send_data(pdf,
              filename: generate_file_name,
              disposition: :attachment)
  end

  def show;end

  def print
    respond_with @booking do |format|
      format.pdf do
        render pdf: generate_file_name,
               template: 'tickets/_ticket.html.haml',
               disposition: :inline,
               layout: "pdf.html"
      end
    end
  end

  def email
    TicketMailer.send_ticket(@booking).deliver
    respond_with @booking, location: ticket_url(@booking), notice: 'Ticket has been emailed successfully'
  end

  private
   def set_booking
     @booking = Booking.find(params[:id]).decorate
   end

   def generate_file_name
     "#{@booking.trip_name}_#{@booking.client_name}_#{Time.zone.now.to_i}.pdf".gsub(' ', '_').downcase
   end

   def generate_pdf
     WickedPdf.new.pdf_from_string(render_to_string(template: 'tickets/_ticket.html.haml', layout: "pdf.html"))
   end
end
