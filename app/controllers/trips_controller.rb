class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  params_for :trip, :name, :start_date, :end_date, :route_id, :bus_id, driver_ids: []

  # GET /trips
  # GET /trips.json
  def index
    @trips = Trip.all
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end


  # POST /trips
  # POST /trips.json
  def create
    @trip = TripBuilderService.new(Trip.new(trip_params)).build
    respond_with(@trip)
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    @trip.update(trip_params)
    respond_with(@trip)
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_with(@trip)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end
end
