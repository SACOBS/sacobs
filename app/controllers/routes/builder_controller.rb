module Routes
  class BuilderController < ApplicationController
    include Wicked::Wizard

    layout 'wizard'

    before_action :set_route, only: [:show, :update]

    steps :route_details, :destinations, :connections

    def create
      @route = Route.create
      redirect_to wizard_path(steps.first, route_id: @route)
    end

    def show
      render_wizard
    end

    def update
      @route.update!(route_params)
      render_wizard @route
    end

    private

    def finish_wizard_path
      routes_url
    end

    def set_route
      @route = Route.find(params[:route_id])
    end

    def route_params
      params.fetch(:route, {}).permit(:name, :cost, :distance,
                                      destinations_attributes: [:city_id, :sequence,  :_destroy],
                                      connections_attributes: [:id, :_destroy, :from_id, :to_id, :distance, :percentage, :cost, :depart, :arrive]
                                     ).merge(user_id: current_user.id)
    end
  end
end
