# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  start_date     :date
#  end_date       :date
#  route_id       :integer
#  bus_id         :integer
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer
#  notes          :text
#  archived       :boolean          default(FALSE)
#  archived_at    :datetime
#  bookings_count :integer          default(0)
#
# Indexes
#
#  index_trips_on_archived  (archived)
#  index_trips_on_bus_id    (bus_id)
#  index_trips_on_route_id  (route_id)
#

class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :copy, :show, :destroy, :update]

  def index
    @trips = Trip.includes(:bus, :route).available.page(params[:page])
    respond_with(@trips) if stale?(@trips)
  end

  def search
    @search = Trip.available.search(params[:q].merge(m: 'or'))
    @results = @search.result.includes(:bus, :route).limit(50)
  end

  def show
    fresh_when @trip
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip::Create.perform(trip_params)
    respond_with(@trip)
  end

  def copy
    copy = Trip::Copy.perform(@trip, current_user)
    if copy.save
      redirect_to copy, notice: t('flash.trips.copy.notice', resource_name: copy.name)
    else
      redirect_to trips_url, alert: t('flash.trips.copy.alert', resource_name: copy.name)
    end
  end

  def update
    @trip = Trip::Update.perform(@trip, trip_params)
    respond_with @trip
  end

  def destroy
    @trip.destroy
    respond_with @trip
  end

  private
  def set_trip
    @trip = Trip.includes(bookings: [:client, stop: :connection], route: { destinations: :city}).find(params[:id])
  end

  def trip_params
    params.fetch(:trip, {}).permit(:name,
                                   :start_date,
                                   :end_date,
                                   :route_id,
                                   :bus_id,
                                   :notes,
                                   driver_ids: []
                                  ).merge(user_id: current_user.id)
  end
end
