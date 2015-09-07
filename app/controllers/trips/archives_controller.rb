class Trips::ArchivesController < ApplicationController
  def index
    @trips = Trip.archived.includes(:bus, :route).page(params[:page])
    fresh_when @trips, template: 'trips/archives/index'
  end

  def show
    @trip = Trip.archived.find(params[:id])
  end

  def search
    @search = Trip.archived.includes(:bus, :route).search(params[:q])
    @results = @search.result.limit(50)
  end
end
