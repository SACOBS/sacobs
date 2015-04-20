class Trips::ArchivesController < ApplicationController
  layout 'with_sidebar', only: :show

  def index
    @trips = trip_scope.page(params[:page])
  end

  def show
    @trip = trip_scope.includes(stops: { connection: [:from, :to] }).order('destinations.sequence desc, tos_connections.sequence desc').find(params[:id])
  end

  def search
    results = trip_scope.search(params[:q]).result(distinct: true).page(params[:page])
    flash[:notice] = "#{view_context.pluralize(results.total_count, 'Result')} found"
    render partial: 'trips/archives/trips', locals: { trips: results }
  end

  private
  def trip_scope
    @trip_scope ||= Trip.archived
  end
end