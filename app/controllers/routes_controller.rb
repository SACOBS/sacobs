class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :destroy]

  def index
    @q = Route.search(params[:q])
    @routes = @q.result(distinct: true).decorate
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
      @route = Route.includes(:connections, :destinations).friendly.find(params[:id])
    end
end
