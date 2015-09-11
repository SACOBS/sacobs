class TripSheetsController < ApplicationController
  before_action :set_trip, except: :index
  before_action :set_trip_sheet_presenter, except: [:index, :edit, :update]

  def index
    @q = Trip.search(params[:q].try(:merge, m: 'or'))
    @trips = @q.result(distinct: true).includes(:route).order(:start_date)
  end

  def update
    @trip.update(params.fetch(:trip, {}).permit(:notes))
    respond_with @trip, location: trip_sheet_url(@trip), action: :edit
  end

  def download
    render pdf: @trip.name,
           template: 'trip_sheets/trip_sheet.pdf.erb',
           disposition: :attachment,
           layout: 'pdf.html'
  end

  def print
    render pdf: @trip.name,
           template: 'trip_sheets/trip_sheet',
           layout: 'pdf.html'
  end

  private
  def set_trip
    @trip = Trip.includes(bookings: [:passengers, { stop: :connection }], route: [destinations: :city]).find(params[:id])
  end

  def set_trip_sheet_presenter
    @trip_sheet_presenter = TripsheetPresenter.new(@trip, view_context, @settings)
  end
end
