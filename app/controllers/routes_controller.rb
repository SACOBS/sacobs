class RoutesController < ApplicationController
  before_action :set_route, except: [:index, :new, :create]

  def index
    @routes = route_scope.all
    fresh_when @routes, last_modified: @routes.maximum(:updated_at)
  end

  def new
    @route = Route.new
  end

  def create
    @route = Route.create!(route_params)
    respond_with(@route)
  end

  def show
    fresh_when @route, last_modified: @route.updated_at
  end

  def update
    @route.update(route_params)
    respond_with @route
  end

  def destroy
    @route.destroy
    respond_with @route
  end

  def copy
    copy = @route.copy
    copy.user_id = current_user.id
    if copy.save
      redirect_to copy, notice: 'Route was successfully copied.'
    else
      redirect_to routes_url, alert: 'Route could not be copied.'
    end
  end

  def reverse_copy
    reverse_copy = @route.reverse_copy
    reverse_copy.user_id = current_user.id
    if reverse_copy.save
      redirect_to reverse_copy, notice: 'Route was successfully reverse copied.'
    else
      redirect_to routes_url, alert: 'Route could not be reverse copied.'
    end
  end

  private

  def route_scope
    Route.includes(:connections).all
  end

  def set_route
    @route = Route.includes(:connections).find(params[:id])
  end

  def route_params
    params.fetch(:route, {}).permit(:name, :cost, :distance,
                                    destinations_attributes: [:city_id, :sequence, :_destroy, :id],
                                    connections_attributes: [:id, :_destroy, :from_id, :to_id, :distance, :percentage, :cost]
                                   ).merge(user_id: current_user.id)
  end
end
