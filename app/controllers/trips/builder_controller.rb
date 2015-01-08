module Trips
  class BuilderController < ApplicationController
    include Wicked::Wizard

    layout 'wizard'

    before_action :set_trip, only: [:show, :update]

    steps :trip_details, :stops

    def create
      @trip = Trip.create(trip_params)
      redirect_to wizard_path(Wicked::FIRST_STEP, trip_id: @trip)
    end

    def show
      render_wizard
    end

    def update
      Trip.no_touching { @trip.update(trip_params) }
      render_wizard @trip
    end

    private

    def finish_wizard_path
      trips_url
    end

    def set_trip
      @trip = Trip.includes(stops: [connection: [from: :city, to: :city]]).find(params[:trip_id])
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
end
