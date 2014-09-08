class PricingController < ApplicationController
  respond_to :js


  def show
    stop =  Stop.find(params[:stop_id])
    @pricing = PricingDecorator.new(stop)
    respond_with @pricing
  end

end
