class AvailabilityController < ApplicationController


  def new
    @trips = Trip.all
  end

  def check
    trip = Trip.find(params[:trip][:id])
    stops = trip.available_stops(params[:trip][:from], params[:trip][:to])
    if stops.empty? || stops.any? { |s| s.available_seats <  params[:trip][:seats].to_i }
      redirect_to availability_new_url, alert: 'There are no available seats'
    else
      booking = trip.bookings.create!(quantity: params[:trip][:seats].to_i)
      booking.stops << stops
      redirect_to root_url
    end
  end
end
