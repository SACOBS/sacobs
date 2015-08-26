class Bookings::ArchivesController < ApplicationController
  def index
    @bookings = Trip.unscoped { booking_scope.includes(:trip, :stop, :client).page(params[:page]) }
    fresh_when @bookings, template: 'bookings/archives/index'
  end

  def search
    @search = Trip.unscoped { booking_scope.includes(:trip, :stop, :client).search(params[:q]) }
    @results = @search.result.includes(:trip, :stop, :client).limit(50)
  end

  def show
    @booking = booking_scope.find(params[:id])
  end

  private

  def booking_scope
    @booking_scope ||= Booking.archived.processed
  end
end
