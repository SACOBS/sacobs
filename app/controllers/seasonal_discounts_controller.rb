class SeasonalDiscountsController < ApplicationController
  responders :collection, :flash

  decorates_assigned :seasonal_discounts

  def index
    @seasonal_discounts = SeasonalDiscount.applicable
  end

  def new
    @seasonal_discount = SeasonalDiscount.new
  end

  def create
   @seasonal_discount = SeasonalDiscount.create(seasonal_discount_params)
   respond_with @seasonal_discount
  end

  def update
    @seasonal_discount = SeasonalDiscount.find(params[:id])
    @seasonal_discount.update!(seasonal_discount_params)
    respond_with @seasonal_discount
  end


  private
   def seasonal_discount_params
     SeasonalDiscountParameters.new(params).permit(user: current_user)
   end
end