# == Schema Information
#
# Table name: seasonal_discounts
#
#  id                :integer          not null, primary key
#  percentage        :decimal(, )
#  period_from       :date
#  period_to         :date
#  active            :boolean          default(TRUE)
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#  passenger_type_id :integer
#  name              :string(255)
#
# Indexes
#
#  index_seasonal_discounts_on_passenger_type_id  (passenger_type_id)
#  index_seasonal_discounts_on_user_id            (user_id)
#

class SeasonalDiscountsController < ApplicationController
  def index
    @seasonal_discounts = SeasonalDiscount.available
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
