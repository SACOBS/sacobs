class Trips::ArchivesController < ApplicationController
  def index
    @trips = trip_scope.page(params[:page])
    fresh_when @trips
  end

  def show
    @trip = trip_scope.find(params[:id])
    respond_to do |format|
      format.html { render layout: 'with_sidebar' }
    end
  end

  def search
    @search = trip_scope.includes(:bus, :route).search(params[:q])
    @results = @search.result.limit(50)
  end

  private

  def trip_scope
    Trip.archived
  end
end
