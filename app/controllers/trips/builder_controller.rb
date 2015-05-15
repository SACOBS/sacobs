class Trips::BuilderController < ApplicationController
  include Wicked::Wizard

  layout 'wizard'

  steps :details, :stops

  def show
    case step
      when :details
        @trip = Trip.new
        session[:trip] = nil
      when :stops
        @trip = Trip.new(session[:trip])
        @trip.build_stops
    end
    render_wizard
  end

  def update
    case step
      when :details
        @trip = Trip.new(trip_params)
        if @trip.valid?
          session[:trip] = trip_params
          redirect_to next_wizard_path
        else
          render :details
        end
      when :stops
        @trip = Trip.new(session[:trip].merge(trip_params))
        if @trip.save
          session[:trip] = nil
          redirect_to @trip
        else
          render :stops
        end
    end
  end

  private
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
