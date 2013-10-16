class Routes::BuilderController < ApplicationController
  include Wicked::Wizard

  before_action :set_route, only: [:show, :update, :destroy]

  params_for :route, :start_city_id, :end_city_id, :cost, :distance, connections_attributes: [:id, :_destroy, :from_city_id, :to_city_id, :distance]

  steps :details, :connections


  def create
    @route = Route.new {|r| r.save(validate: false)}
    redirect_to wizard_path(steps.first, route_id: @route)
  end

  def show
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
    @route =  Route.find(params[:route_id])
  end
end
