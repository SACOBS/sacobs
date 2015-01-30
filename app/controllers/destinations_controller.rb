class DestinationsController < ApplicationController
  before_action :set_route

  def update
    destination = @route.destinations.create(city: city, sequence: sequence)
    @route.save
    if destination.persisted?
      redirect_to edit_route_url(@route), notice: 'New destination was successfully added.'
    else
      flash[:alert] = destination.errors.full_messages.join(',')
      render :edit
    end
  end

  def cities
    @cities ||= City.all.to_json(only: [:id, :name])
  end
  helper_method :cities

  def destinations
    @destinations ||= @route.destinations.to_json(only: [:id], methods: :city_name)
  end
  helper_method :destinations

  private

  def set_route
    @route = Route.find(params[:route_id])
  end

  def city
     City.find_by(id: destination_params[:city_id])
  end

  def preceding_destination
    @route.destinations.find_by(id: destination_params[:preceding_id])
  end

  def sequence
     (preceding_destination.try(:sequence) || 0).next
  end

  def destination_params
    params.require(:destination).permit(:city_id, :preceding_id)
  end
end
