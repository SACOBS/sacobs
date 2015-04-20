class TripSheetsController < ApplicationController
  before_action :set_trip, except: :index
  before_action :set_trip_sheet_presenter, except: [:index, :edit, :update]

  def index
    @q = Trip.includes(:route).search(params[:q])
    @trips = @q.result(distinct: true).order(start_date: :asc)
    render layout: 'with_sidebar'
  end

  def update
    @trip.update(params.fetch(:trip, {}).permit(:notes))
    respond_with @trip, location: trip_sheet_url(@trip), action: :edit
  end

  def download
    render_pdf(disposition: :attachment)
  end

  def print
    render_pdf
  end

  private
  def render_pdf(disposition: :inline)
    render pdf: @trip.to_file_name,
           template: 'trip_sheets/_trip_sheet.html.haml',
           disposition: disposition,
           layout: 'pdf.html'
  end

  def set_trip
    @trip = Trip.unscoped { Trip.includes(stops: { connection: [:from, :to] }).order('destinations.sequence desc, tos_connections.sequence desc').find(params[:id]) }
  end

  def set_trip_sheet_presenter
    @trip_sheet_presenter = TripsheetPresenter.new(@trip, view_context)
  end

end
