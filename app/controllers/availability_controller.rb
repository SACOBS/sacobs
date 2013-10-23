class AvailabilityController < ApplicationController


  def new
    @trips = Trip.all
  end

  def check
    departing = trip.stops.departing(from_city).first
    destination = trip.stops.destination(to_city).first
    stops = trip.stops.en_route(departing, destination)
    if stops.empty? || stops.any? { |s| s.available_seats < seats }
      flash.now[:alert] = 'There are no available seats.'
      render :new
    else
      redirect_to root_url
    end
  end
end
