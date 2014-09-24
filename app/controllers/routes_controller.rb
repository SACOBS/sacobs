class RoutesController < ApplicationController
  before_action :set_route, only: [:copy, :reverse_copy ,:show, :edit, :update,:destroy]

  def index
    @q = Route.search(params[:q])
    @routes = @q.result(distinct: true).page(params[:page])
  end

  def show
    fresh_when @route, last_modified: @route.updated_at
  end

  def update
      @route.transaction do
        Route.no_touching do
          @route.update(route_params)
          @route.connections.each(&:save!)
        end
        @route.touch
      end
    respond_with @route
  end

  def destroy
    Route.no_touching { @route.destroy }
    respond_with @route
  end

  def copy
    copy = @route.amoeba_dup
    copy.user = current_user
    Route.no_touching { copy.save }
    respond_with copy, location: routes_url
  end
  
  def reverse_copy
    reverse_copy = ReverseRouteBuilder.new(@route).build
    Route.no_touching { reverse_copy.save }
    respond_with reverse_copy, location: routes_url
  end

  private
    def set_route
      @route = Route.friendly.find(params[:id])
    end

    def route_params
      RouteParameters.new(params).permit(user: current_user)
    end
end
