class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :copy, :show, :destroy, :update]
  layout 'with_sidebar', only: :show

  def index
    @trips = trip_scope.includes(:bus, :route, :bookings).page(params[:page])
  end

  def search
    results = trip_scope.search(params[:q]).result(distinct: true).page(params[:page])
    flash[:notice] = "#{view_context.pluralize(results.size, 'Result')} found"
    render partial: 'trips', locals: { trips: results }
  end

  def show
    #fresh_when @trip, last_modified: @trip.updated_at
  end

  def copy
    copy = @trip.copy
    copy.user = current_user
    if copy.save
      redirect_to copy, notice: 'Trip was successfully copied.'
    else
      redirect_to trips_url, alert: 'Trip could not be copied.'
    end
  end

  def update
    @trip.update(trip_params)
    respond_with @trip
  end

  def destroy
    Trip.no_touching { @trip.destroy }
    respond_with @trip
  end

  private

  def trip_scope
    @trip_scope ||= Trip.all
  end

  def set_trip
    @trip = trip_scope.ordered_by_stops.find(params[:id])
  end

  def trip_params
    params.fetch(:trip, {}).permit(:name,
                                   :start_date,
                                   :end_date,
                                   :route_id,
                                   :bus_id,
                                   :notes,
                                   driver_ids: [],
                                   stops_attributes: [:id,
                                                      :arrive,
                                                      :depart,
                                                      :_destroy,
                                                      :connection_id,
                                                      :available_seats]
                                  )
  end
end
