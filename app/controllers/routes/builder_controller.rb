class Routes::BuilderController < ApplicationController
  include Wicked::Wizard

  before_action :set_route, only: [:show, :update, :destroy]

  params_for :route, :name, :cost, :distance, connections_attributes: [:id, :_destroy, :from_destination_id, :to_destination_id, :distance, :percentage], destinations_attributes: [:city_id, :destination_order]

  steps :details, :destinations ,:connections

  def create
    @route = Route.create
    redirect_to wizard_path(steps.first, route_id: @route)
  end

  def show
    build_connections if step == :connections
    render_wizard
  end

  def update
    @route.update(route_params)
    render_wizard @route
  end

  def destroy
    @route.destroy if @route.empty?
    redirect_to_finish_wizard
  end

  private
    def finish_wizard_path
      routes_url
    end

    def set_route
      @route =  Route.friendly.find(params[:route_id])
    end

    def build_connections
      ConnectionBuilder.new(@route).tap {|builder| builder.build }
    end
end
