class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :copy, :show, :destroy, :update]

  decorates_assigned :trips
  decorates_assigned :trip

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
    copy.save
    respond_with copy, location: trips_url
  end

  def update
    @trip.update(trip_params)
    respond_with @trip
  end

  def destroy
    @trip.destroy
    respond_with(@trip)
  end

  private
    def set_trip
      @trip = Trip.includes(stops: :connection).find(params[:id])
    end

    def trip_params
      TripParameters.new(params).permit(user: current_user)
    end
end
