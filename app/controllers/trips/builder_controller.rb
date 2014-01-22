class Trips::BuilderController < ApplicationController
  include Wicked::Wizard

  before_action :set_trip, only: [:show, :update]

  steps :details, :stops

  def create
    @trip = Trip.create
    redirect_to wizard_path(Wicked::FIRST_STEP, trip_id: @trip)
  end

  def show
    render_wizard
  end

  def update
    @trip.update(trip_params)
    render_wizard @trip
  end


  private
    def finish_wizard_path
      trips_url
    end

    def set_trip
      @trip =  Trip.find(params[:trip_id])
    end

    def trip_params
      TripParameters.new(params).permit(user: current_user)
    end
end
