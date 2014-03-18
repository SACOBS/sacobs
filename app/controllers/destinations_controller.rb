class DestinationsController < ApplicationController
  before_action :set_route

  def edit;end

  def update
    @route.transaction do
      city = City.find(destination_params[:city])
      raise 'Destination already exists' if @route.destinations.exists?(city: city)
      preceding_destination = @route.destinations.find_by(city_id: destination_params[:preceding_city])
      DestinationSequencer.new(@route, city, preceding_destination).resequence
      @route.reload
      ConnectionBuilder.new(@route).build
      @route.save
    end
    redirect_to edit_route_url(@route), notice: 'New destination was successfully added.'
  rescue => e
    flash[:alert] = e.message
    render :edit
  end

  private
   def set_route
     @route = Route.friendly.find(params[:route_id])
   end

   def destination_params
     params.require(:destination).permit(:city, :preceding_city)
   end
end