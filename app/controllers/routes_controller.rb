class RoutesController < ApplicationController
  before_action :set_route, only: [:copy, :reverse_copy, :show, :edit, :update, :destroy]

  def index
    @routes = route_scope
  end

  def show
    fresh_when @route, last_modified: @route.updated_at
  end

  def update
    @route.user = current_user
    @route.update(route_params)
    respond_with @route
  end

  def destroy
    @route.destroy
    respond_with @route
  end

  def copy
    copy = @route.amoeba_dup
    copy.user = current_user
    Route.no_touching { copy.save! }
    respond_with copy, location: routes_url
  end

  def reverse_copy
    reverse_copy = ReverseRouteBuilder.new(@route).build
    Route.no_touching { reverse_copy.save }
    respond_with reverse_copy, location: routes_url
  end

  private

  def route_scope
    @route_scope ||= Route.all
  end

  def set_route
    @route = Route.friendly.find(params[:id])
  end

  def route_params
    params.fetch(:route, {}).permit(:name, :cost, :distance,
                                    destinations_attributes: [:city_id, :sequence, :_destroy],
                                    connections_attributes: [:id, :_destroy, :from_id, :to_id, :distance, :percentage, :cost, :depart, :arrive]
    )
  end
end
