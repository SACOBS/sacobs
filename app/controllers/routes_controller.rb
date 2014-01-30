class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update,:destroy]
  decorates_assigned :routes
  decorates_assigned :route

  def index
    @q = Route.search(params[:q])
    @routes = @q.result(distinct: true)
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
    respond_with(@route, location: routes_url)
  end

  private
    def set_route
      @route = Route.includes(:connections, :destinations).friendly.find(params[:id])
    end

    def route_params
      RouteParameters.new(params).permit(user: current_user)
    end
end
