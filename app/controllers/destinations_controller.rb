class DestinationsController < ApplicationController
  before_action :set_route

  def update
    if @route.destinations.exists?(city: new_destination)
      flash[:alert] = 'Destination already exists'
      render :edit
    else
      create_new_destination
      redirect_to edit_route_url(@route), notice: 'New destination was successfully added.'
    end
  end

  def cities
    @cities ||= City.all.to_json(only: [:id, :name])
  end
  helper_method :cities

  private

  def set_route
    @route = Route.includes(connections: [from: :city, to: :city], destinations: :city).find(params[:route_id])
  end

  def destination_params
    params.require(:destination).permit(:city_id, :preceding_city_id)
  end

  def create_new_destination
    @route.transaction do
      resequence_destinations
      @route.reload
      build_connection
      @route.save
    end
  end

  def new_destination
    City.find(destination_params[:city_id])
  end

  def preceding_destination
    @route.destinations.find_by(city_id: destination_params[:preceding_city_id])
  end

  def resequence_destinations
    DestinationSequencer.new(@route, new_destination, preceding_destination).resequence
  end

  def build_connection
    ConnectionBuilder.new(@route).build
  end
end
