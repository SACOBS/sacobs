class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :copy, :show, :destroy, :update]
  layout 'with_sidebar', only: :show

  def index
    @trips = Trip.all.includes(:bus, :route, :bookings).page(params[:page])
  end

  def search
    @search = Trip.includes(:bus, :route, :bookings).search(params[:q])
    @results = @search.result.limit(50)
  end

  def show
    fresh_when @trip, last_modified: @trip.updated_at
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

  def set_trip
    @trip = Trip.find(params[:id])
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
