class Trips::ArchivesController < ApplicationController
  layout 'with_sidebar', only: :show

  def index
    @trips = trip_scope.includes(:route, :bus).page(params[:page])
  end

  def show
   @trip = trip_scope.find(params[:id])
  end

  def search
    results = @trip_scope.search(params[:q]).result(distinct: true).page(params[:page])
    flash[:notice] = "#{view_context.pluralize(results.size, 'Result')} found"
    render partial: 'trips', locals: { archived_trips: results }
  end

  private
  def trip_scope
    @trip_scope ||= Trip.archived
  end
end