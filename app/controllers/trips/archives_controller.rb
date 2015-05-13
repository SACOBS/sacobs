class Trips::ArchivesController < ApplicationController
  layout 'with_sidebar', only: :show

  def index
    @trips = trip_scope.page(params[:page])
  end

  def show
    @trip = trip_scope.ordered_by_stops.find(params[:id])
  end

  def search
    @search = trip_scope.includes(:bus, :route).search(params[:q])
    @results = @search.result.limit(50)
  end

  private

  def trip_scope
    @trip_scope ||= Trip.archived
  end
end
