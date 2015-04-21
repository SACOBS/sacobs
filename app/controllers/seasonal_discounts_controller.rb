class SeasonalDiscountsController < ApplicationController
  responders :collection, :flash

  def index
    @seasonal_discounts = SeasonalDiscount.applicable
  end

  def new
    @seasonal_discount = SeasonalDiscount.new
  end

  def create
    @seasonal_discount = SeasonalDiscount.new(seasonal_discount_params)
    @seasonal_discount.user = current_user
    @seasonal_discount.save
    respond_with @seasonal_discount
  end

  def update
    @seasonal_discount = SeasonalDiscount.find(params[:id])
    @seasonal_discount.user = current_user
    @seasonal_discount.update(seasonal_discount_params)
    respond_with @seasonal_discount
  end

  private

  def seasonal_discount_params
    params.fetch(:seasonal_discount, {}).permit(:name,
                                                :passenger_type_id,
                                                :percentage,
                                                :period_from,
                                                :period_to,
                                                :active
                                               )
  end
end
