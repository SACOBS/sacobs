class DiscountsController < ApplicationController
  responders :flash, :collection

  before_action :set_discount, only: [:edit, :update, :destroy]

  def index
    @discounts = Discount.includes(:passenger_type).select(:id, :percentage, :passenger_type_id, :updated_at)
  end

  def new
    @discount = Discount.new
    @discount.build_passenger_type
  end

  def create
    @discount = Discount.create(discount_params)
    respond_with @discount
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
