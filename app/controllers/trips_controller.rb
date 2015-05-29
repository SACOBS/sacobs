class TripsController < ApplicationController
  layout 'with_sidebar', only: :show

  before_action :build_trip, only: [:new, :create]
  before_action :set_trip, only: [:edit, :copy, :show, :destroy, :update]

  def index
    @trips = trip_scope.includes(:bus, :route).page(params[:page])
    if stale?(@trips)
      respond_with(@trips)
    end
  end

  def search
    @search = trip_scope.search(params[:q])
    @results = @search.result.limit(50)
  end

  def show
    fresh_when @trip, last_modified: @trip.updated_at
  end

  def create
    @trip.save
    respond_with(@trip)
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
    @trip.destroy
    respond_with @trip
  end

  private

  def trip_scope
    Trip.all
  end

  def build_trip
    @trip = Trip.new(trip_params)
  end

  def set_trip
    @trip = trip_scope.includes(:bookings, :bus, :route).find(params[:id])
  end

  def trip_params
    params.fetch(:trip, {}).permit(:name,
                                   :start_date,
                                   :end_date,
                                   :route_id,
                                   :bus_id,
                                   :notes,
                                   driver_ids: []
                                  )
  end
end
