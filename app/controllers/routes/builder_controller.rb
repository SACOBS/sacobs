class Routes::BuilderController < ApplicationController
  include Wicked::Wizard

  params_for :route, :start_city_id, :end_city_id, :cost, :distance, connections_attributes: [:id, :_destroy, :from_city_id, :to_city_id, :distance]

  steps :details, :connections


  def create
    @route = Route.new.tap {|r| r.save(validate: false)}
    redirect_to wizard_path(steps.first, route_id: @route)
  end

  def show
    @route = find_route(params[:route_id])
    render_wizard
  end

  def update
    @route = find_route(params[:route_id])
    @route.update(route_params)
    render_wizard @route
  end

  private
  def finish_wizard_path
    routes_url
  end

  def find_route(id)
    Route.find(id)
  end

end
