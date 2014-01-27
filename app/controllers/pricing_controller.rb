class PricingController < ApplicationController
  respond_to :js

  def show
    @pricing = PricingDecorator.new(Stop.find(params[:stop_id]))
    respond_with @pricing
  end
end
