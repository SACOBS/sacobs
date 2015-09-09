class DestinationsController < ApplicationController
  before_action :set_route

  def update
    if @route.update(route_params)
      redirect_to edit_route_url(@route), notice: 'New destination was successfully added.'
    else
      flash.now[:alert] = 'Destinations could not be updated.'
      render :edit
    end
  end

  def destinations
    @destinations ||= @route.destinations.map(&:city).to_json(only: [:id, :name])
  end
  helper_method :destinations

  private

  def set_route
    @route = Route.find(params[:route_id])
  end

  def route_params
    params.require(:route).permit(destinations_attributes: [:city_id, :sequence, :id])
  end
end
