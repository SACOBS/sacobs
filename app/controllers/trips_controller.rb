class TripsController < ApplicationController
  layout 'with_sidebar', only: :show

  before_action :build_trip, only: [:new, :create]
  before_action :set_trip, only: [:edit, :copy, :show, :destroy, :update]

  after_action :verify_authorized
  after_action :verify_policy_scoped, only: [:index, :search]

  def index
    authorize Trip
    @trips = trip_scope.page(params[:page])
    fresh_when @trips
  end

  def search
    authorize Trip
    @search = trip_scope.search(params[:q])
    @results = @search.result.limit(50)
  end

  def show
    authorize @trip
    fresh_when @trip, last_modified: @trip.updated_at
  end

  def new
    authorize @trip
  end

  def create
    authorize @trip
    @trip.save
    respond_with(@trip)
  end

  def copy
    authorize @trip

    copy = @trip.copy
    copy.user = current_user
    if copy.save
      redirect_to copy, notice: 'Trip was successfully copied.'
    else
      redirect_to trips_url, alert: 'Trip could not be copied.'
    end
  end

  def edit
    authorize @trip
  end

  def update
    authorize @trip
    @trip.update(trip_params)
    respond_with @trip
  end

  def destroy
    authorize @trip
    @trip.destroy
    respond_with @trip
  end

  private

  def trip_scope
    policy_scope(Trip).includes(:bus, :route, :bookings)
  end

  def build_trip
    @trip = Trip.new(trip_params)
  end

  def set_trip
    @trip = trip_scope.find(params[:id])
  end

  def trip_params
    params.fetch(:trip, {}).permit(:name,
                                   :start_date,
                                   :end_date,
                                   :route_id,
                                   :bus_id,
                                   :notes,
                                   driver_ids: []
                                  )
  end
end
