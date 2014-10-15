class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :copy, :show, :destroy, :update]

  def calendar
    @trips = trip_scope
  end

  def index
    @trips = trip_scope.page(params[:page])
  end

  def search
    results = trip_scope.search(params[:q]).result(distinct: true).page(params[:page])
    flash[:notice] = "#{view_context.pluralize(results.size, 'Result')} found"
    render partial: 'trips', locals: { trips: results }
  end

  def archived
    @archived_trips = archived_trip_scope.page(params[:page])
  end

  def search_archived
    results = archived_trip_scope.search(params[:q]).result(distinct: true).page(params[:page])
    flash[:notice] = "#{view_context.pluralize(results.size, 'Result')} found"
    render partial: 'archived_trips', locals: { archived_trips: results }
  end

  def show
    fresh_when @trip, last_modified: @trip.updated_at
  end

  def copy
    copy = @trip.amoeba_dup
    copy.user = current_user
    Trip.no_touching { copy.save }
    respond_with copy, location: trips_url
  end

  def update
    @trip.update(trip_params)
    respond_with @trip
  end

  def destroy
    Trip.no_touching { @trip.destroy }
    respond_with @trip
  end

  private

  def trip_scope
    @trip_scope ||= Trip.includes(:route, :bus).valid
  end

  def archived_trip_scope
    @archived_trip_scope ||= Trip.includes(:route, :bus).archived
  end

  def set_trip
    @trip = Trip.includes(stops: :connection).find(params[:id])
  end

  def trip_params
    params.fetch(:trip, {}).permit(:name,
                                   :start_date,
                                   :end_date,
                                   :route_id,
                                   :bus_id,
                                   :notes,
                                   driver_ids: [],
                                   stops_attributes: [:id,
                                                      :arrive,
                                                      :depart,
                                                      :_destroy,
                                                      :connection_id,
                                                      :available_seats]
    )
  end
end
