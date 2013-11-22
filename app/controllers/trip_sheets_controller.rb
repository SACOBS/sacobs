class TripSheetsController < ApplicationController
  before_action :set_trip

  def show
  end

  def print
    respond_with(@trip, file_name: "#{@trip.name}_#{Time.zone.now.to_i}".downcase)
  end

  private
   def set_trip
     @trip = Trip.find(params[:id])
   end
end
