class Trips::ArchivesController < ApplicationController
  def index
    @trips = Trip.archived.page(params[:page])
    fresh_when @trips
  end

  def show
    @trip = Trip.archived.find(params[:id])
    respond_to do |format|
      format.html { render layout: 'with_sidebar' }
    end
  end

  def search
    @search = trip_scope.includes(:bus, :route).search(params[:q])
    @results = @search.result.limit(50)
  end
end
