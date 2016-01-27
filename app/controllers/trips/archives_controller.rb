class Trips::ArchivesController < ApplicationController
  def index
    @trips = Trip.includes(:bus, :route).archived.page(params[:page])
    fresh_when @trips, template: 'trips/archives/index'
  end

  def search
    @search = Trip.archived.search(params[:q].merge(m: 'or'))
    @results = @search.result.includes(:bus, :route).limit(50)
  end

  def show
    @trip = Trip.includes(bookings: [:client, stop: :connection]).find(params[:id])
  end
end
