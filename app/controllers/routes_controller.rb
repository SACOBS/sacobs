class RoutesController < ApplicationController
  before_action :set_route, except: [:index, :new, :create]

  def index
    @routes = route_scope.includes(:destinations, :connections)
    respond_with(@routes)
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
    copy = @route.copy { |c| c.user_id = current_user.id }
    if copy.persisted?
      redirect_to copy, notice: 'Route was successfully copied.'
    else
      redirect_to routes_url, alert: 'Route could not be copied.'
    end
  end

  def reverse_copy
    reverse_copy = @route.reverse_copy { |c| c.user_id = current_user.id }
    if reverse_copy.persisted?
      redirect_to reverse_copy, notice: 'Route was successfully reverse copied.'
    else
      redirect_to routes_url, alert: 'Route could not be reverse copied.'
    end
  end

  private

  def route_scope
    Route.all
  end

  def set_route
    @route = Route.includes(:connections, :destinations).find(params[:id])
  end

  def route_params
    params.fetch(:route, {}).permit(:name, :cost, :distance,
                                    destinations_attributes: [:city_id, :sequence, :_destroy, :id],
                                    connections_attributes: [:id, :_destroy, :from_id, :to_id, :distance, :percentage, :cost]
                                   ).merge(user_id: current_user.id)
  end
end
