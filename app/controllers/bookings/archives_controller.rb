class Bookings::ArchivesController < ApplicationController
  def index
    @bookings = booking_scope.includes(:stop, :client).page(params[:page])
  end

  def search
    @search = booking_scope.search(params[:q])
    @results = @search.result.includes(:stop, :client, :trip).limit(50)
  end

  def show
    @booking = booking_scope.find(params[:id])
  end

  private

  def booking_scope
    @booking_scope ||= Booking.archived.processed
  end
end
