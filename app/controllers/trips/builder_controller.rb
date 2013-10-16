class Trips::BuilderController < ApplicationController
  include Wicked::Wizard

  before_action :set_trip, only: [:destroy, :show, :update]

  params_for :trip, :name, :start_date, :end_date, :route_id, :bus_id, driver_ids: [], stops_attributes: [:id, :_destroy, :arrive, :depart]

  steps :details, :stops


  def create
    @trip = Trip.new {|r| r.save(validate: false)}
    redirect_to wizard_path(steps.first, trip_id: @trip)
  end

  def show
    render_wizard
  end

  def update
    @trip = TripService.new(@trip).update(trip_params)
    render_wizard @trip
  end

  def destroy
    @trip.destroy if @trip.empty?
    redirect_to_finish_wizard
  end

  private
  def finish_wizard_path
    trips_url
  end

  def set_trip
    @trip =  Trip.find(params[:trip_id])
  end


end
