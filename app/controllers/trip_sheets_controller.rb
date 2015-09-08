class TripSheetsController < ApplicationController
  before_action :set_trip, except: :index
  before_action :set_trip_sheet_presenter, except: [:index, :edit, :update]

  def index
    @q = Trip.includes(:route).search(params[:q])
    @trips = @q.result(distinct: true).order(start_date: :asc)
  end

  def update
    @trip.update(params.fetch(:trip, {}).permit(:notes))
    respond_with @trip, location: trip_sheet_url(@trip), action: :edit
  end

  def download
    render pdf: @trip.to_file_name,
           template: 'trip_sheets/trip_sheet.pdf.erb',
           disposition: :attachment,
           layout: 'pdf.html'
  end

  def print
    render pdf: @trip.to_file_name,
           template: 'trip_sheets/trip_sheet',
           layout: 'pdf.html'
  end

  private
  def set_trip
    @trip = Trip.unscoped { Trip.find(params[:id]) }
  end

  def set_trip_sheet_presenter
    @trip_sheet_presenter = TripsheetPresenter.new(@trip, view_context, @settings)
  end
end
