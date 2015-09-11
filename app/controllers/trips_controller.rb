class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :copy, :show, :destroy, :update]

  def index
    @trips = Trip.includes(:bus, :route).page(params[:page])
    respond_with(@trips) if stale?(@trips)
  end

  def search
    @search = Trip.search(params[:q].merge(m: 'or'))
    @results = @search.result.includes(:bus, :route).limit(50)
  end

  def show
    fresh_when @trip
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.create(trip_params)
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
  def set_trip
    @trip = Trip.includes(bookings: [:client, stop: :connection], route: { destinations: :city}).find(params[:id])
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
