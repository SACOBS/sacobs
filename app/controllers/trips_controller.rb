class TripsController < ApplicationController
  before_action :set_trip, only: [:copy, :show, :destroy]

  def index
    @trips = Trip.all
  end

  def show
    @trip = @trip.decorate
  end

  def copy
    new_trip = @trip.amoeba_dup
    new_trip.user_id = current_user.id
    if new_trip.save
      redirect_to trip_builder_path(:details, trip_id: new_trip)
    else
      redirect_to :index, alert: 'There was an error while copying the trip. Please try again.'
    end
  end

  def destroy
    @trip.destroy
    respond_with(@trip)
  end

  private
    def set_trip
      @trip = Trip.includes(:stops).find(params[:id])
    end
end
