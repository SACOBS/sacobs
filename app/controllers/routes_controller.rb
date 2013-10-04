class RoutesController < ApplicationController

  params_for :route, :start_city_id, :end_city_id, :cost, :distance

  def index
    @routes = Route.all
  end

  def new
    @route = build_route
  end

  def create
    @route = build_route
    @route.save
    respond_with(@route)
  end

  def show
    @route = find_route(params[:id])
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private
  def find_route(id)
    Route.find(id)
  end

  def build_route
    Route.new(route_params)
  end
end
