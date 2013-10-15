class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :destroy]

  params_for :trip, :name, :start_date, :end_date, :route_id, :bus_id, driver_ids: []

  def index
    @trips = Trip.all
  end

  def destroy
    @trip.destroy
    respond_with(@trip)
  end

  private
    def set_trip
      @trip = Trip.find(params[:id])
    end
end
