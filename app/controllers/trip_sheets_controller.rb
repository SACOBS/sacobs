class TripSheetsController < ApplicationController
  before_action :set_trip, except: :index

  def index
    @q = Trip.includes(:route, :bookings).search(params[:q])
    @trips = @q.result(distinct: true).order(start_date: :asc)
    render layout: 'with_sidebar'
  end

  def download
    html = render_to_string(template: 'trip_sheets/_trip_sheet.html.haml', layout: "pdf.html")
    pdf = WickedPdf.new.pdf_from_string(html)
    send_data(pdf,filename: generate_file_name,disposition: :attachment)
  end

  def print
    respond_with @trip do |format|
      format.pdf do
          render pdf: generate_file_name,
                 disposition: :inline,
                 template: 'trip_sheets/_trip_sheet.html.haml',
                 layout: "pdf.html"
      end
    end
  end

  private
   def set_trip
     @trip = Trip.find(params[:id])
   end

   def generate_file_name
     "#{@trip.name}_#{Time.zone.now.to_i}.pdf".gsub(' ', '_').downcase
   end
end
