class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :copy, :show, :destroy, :update]

  def calendar
    @trips = Trip.includes(:route, :bus).all
  end

  def index
    @q = Trip.includes(:route, :bus).valid.search(params[:q])
    @trips = @q.result(distinct: true).page(params[:page])
  end

  def archived
    @q = Trip.includes(:route, :bus).archived.search(params[:q])
    @trips = @q.result(distinct: true).page(params[:page])
  end

  def show
    fresh_when @trip, last_modified: @trip.updated_at
  end

  def copy
    copy = @trip.amoeba_dup
    copy.user = current_user
    Trip.no_touching { copy.save }
    respond_with copy, location: trips_url
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
    @trip = Trip.includes(stops: :connection).find(params[:id])
  end

  def trip_params
    TripParameters.new(params).permit(user: current_user)
  end
end
