class AvailabilityController < ApplicationController


  def check
    @trips = AvailabilityService.new(params[:availability]).check
  end
end
