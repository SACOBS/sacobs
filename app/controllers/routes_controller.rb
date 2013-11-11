class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :destroy]

  def index
    @routes = Route.all
  end

  def show
    @route = @route.decorate
  end

  def destroy
    @route.destroy
    respond_with(@route, location: routes_url)
  end

  private
  def set_route
    @route = Route.includes(:connections, :start_city, :end_city).friendly.find(params[:id])
  end
end