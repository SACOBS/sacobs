class Routes::BuilderController < ApplicationController
  include Wicked::Wizard

  before_action :set_route, only: [:show, :update]

  steps :details, :destinations ,:connections

  def create
    @route = Route.create
    redirect_to wizard_path(steps.first, route_id: @route)
  end

  def show
    case step
      when :connections then build_connections
    end
    render_wizard
  end

  def update
    Route.no_touching { @route.update(route_params) }
    render_wizard @route
  end


  private
    def finish_wizard_path
      routes_url
    end

    def set_route
      @route = Route.friendly.find(params[:route_id])
    end

    def build_connections
      ConnectionBuilder.new(@route).tap {|builder| builder.build }
    end

    def route_params
      RouteParameters.new(params).permit(user: current_user)
    end
end
