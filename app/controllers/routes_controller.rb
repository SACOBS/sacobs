class RoutesController < ApplicationController


  def index
    @routes = Route.all
  end

  def show
    @route = find_route(params[:id])
  end


  def destroy
    @route = find_route(params[:id])
    @route.destroy
    respond_with @route
  end

  private
  def find_route(id)
    Route.find(id)
  end
end
