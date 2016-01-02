# == Schema Information
#
# Table name: destinations
#
#  id         :integer          not null, primary key
#  route_id   :integer
#  city_id    :integer
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_destinations_on_city_id               (city_id)
#  index_destinations_on_city_id_and_route_id  (city_id,route_id)
#  index_destinations_on_route_id              (route_id)
#  index_destinations_on_sequence              (sequence)
#

class DestinationsController < ApplicationController
  before_action :set_route

   def update
      @route = Route::Update.new(@route, route_params).perform
      respond_with(@route, location: edit_route_url(@route))
   end

  private

  def set_route
    @route = Route.includes(destinations: :city).find(params[:route_id])
  end

  def route_params
    params.require(:route).permit(destinations_attributes: [:city_id, :sequence, :id])
  end
end
