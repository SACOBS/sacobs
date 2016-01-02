# == Schema Information
#
# Table name: routes
#
#  id                :integer          not null, primary key
#  cost              :decimal(8, 2)
#  distance          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  name              :string(255)
#  user_id           :integer
#  connections_count :integer          default(0)
#

class RoutesController < ApplicationController
  before_action :set_route, except: [:index, :new, :create]

  def index
    @routes = Route.all
    respond_with(@routes) if stale?(@routes)
  end

  def new
    @route = RouteForm.new
  end

  def create
    @route = Route::Create.perform(route_params)
    respond_with(@route)
  end

  def show
    fresh_when @route
  end

  def update
    @route = Route::Update.perform(@route, route_params)
    respond_with @route
  end

  def destroy
    @route.destroy
    respond_with @route
  end

  def copy
    copy = Route::Copy.perform(@route, current_user)
    if copy.save!
      redirect_to copy, notice:  t('flash.routes.copy.notice', resource_name: copy.name)
    else
      redirect_to routes_url, alert: t('flash.routes.copy.alert', resource_name: @route.name)
    end
  end

  def reverse_copy
    copy = Route::ReverseCopy.perform(@route, current_user)
    if copy.save
      redirect_to copy, notice:  t('flash.routes.copy.notice', resource_name: copy.name)
    else
      redirect_to routes_url, alert: t('flash.routes.copy.alert', resource_name: @route.name)
    end
  end

  private
  def set_route
    @route = Route.includes(:connections, destinations: :city).find(params[:id])
  end

  def route_params
    params.fetch(:route, {}).permit(:name, :cost, :distance,
                                    destinations_attributes: [:city_id, :sequence, :_destroy, :id],
                                    connections_attributes: [:id, :_destroy, :from_id, :to_id, :distance, :percentage, :cost, :leaving, :arriving]
                                   ).merge(user_id: current_user.id)
  end
end
