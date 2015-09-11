class SeasonalDiscountsController < ApplicationController
  def index
    @seasonal_discounts = SeasonalDiscount.applicable
  end

  def new
    @seasonal_discount = SeasonalDiscount.new
  end

  def create
    @seasonal_discount = SeasonalDiscount.create(seasonal_discount_params)
    respond_with @seasonal_discount, location: seasonal_discounts_url
  end

  def update
    @seasonal_discount = SeasonalDiscount.find(params[:id])
    @seasonal_discount.update(seasonal_discount_params)
    respond_with @seasonal_discount, location: seasonal_discounts_url
  end

  private

  def seasonal_discount_params
    params.fetch(:seasonal_discount, {}).permit(:name,
                                                :passenger_type_id,
                                                :percentage,
                                                :period_from,
                                                :period_to,
                                                :active
                                               ).merge(user_id: current_user.id)
  end
end
