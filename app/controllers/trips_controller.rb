class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :copy, :show, :destroy, :update]
  decorates_assigned :trips
  decorates_assigned :trip

  def index
    @q = Trip.search(params[:q])
    @trips = @q.result(distinct: true)
  end

  def show
    fresh_when @trip, last_modified: @trip.updated_at
  end

  def copy
    new_trip = @trip.amoeba_dup
    new_trip.user = current_user
    if new_trip.save
      redirect_to trip_builder_path(:details, trip_id: new_trip)
    else
      redirect_to :index, alert: 'There was an error while copying the trip. Please try again.'
    end
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
