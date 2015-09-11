class Bookings::ArchivesController < ApplicationController
  def index
    @bookings = Booking.includes(:client, :trip, stop: :connection).archived.page(params[:page])
  end

  def search
    @search = Booking.archived.search(params[:q].merge(m: 'or'))
    @results = @search.result.includes(:client, :trip, stop: :connection).limit(50)
  end

  def show
    @booking = Booking.archived.find(params[:id])
  end
end
