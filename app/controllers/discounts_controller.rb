# == Schema Information
#
# Table name: discounts
#
#  id                :integer          not null, primary key
#  percentage        :decimal(5, 2)
#  passenger_type_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#
# Indexes
#
#  index_discounts_on_passenger_type_id  (passenger_type_id)
#

class DiscountsController < ApplicationController
  before_action :set_discount, only: [:edit, :update, :destroy]

  def index
    @discounts = Discount.includes(:passenger_type).all
  end

  def new
    @discount = Discount.new
    @discount.build_passenger_type
  end

  def create
    @discount = Discount.create(discount_params)
    respond_with @discount, location: discounts_url
  end

  def update
    @discount.update(discount_params)
    respond_with @discount
  end

  def destroy
    @discount.destroy
    respond_with @discount
  end

  private

  def set_discount
    @discount = Discount.find(params[:id])
  end

  def discount_params
    params.fetch(:discount, {}).permit(:percentage,
                                       passenger_type_attributes: [:description]
                                      ).merge(user_id: current_user.id)
  end
end
