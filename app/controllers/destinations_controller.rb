class DestinationsController < ApplicationController
  before_action :set_route

   def update
      @route = Route::Update.new(@route, route_params).perform
      respond_with(@route, location: edit_route_url(@route))
   end

  private

  def set_route
    @route = Route.find(params[:route_id])
  end

  def route_params
    params.require(:route).permit(destinations_attributes: [:city_id, :sequence, :id])
  end
end
