class DiscountsController < ApplicationController
  before_action :set_discount, only: [:edit, :update, :destroy]

  params_for :discount, :percentage, :passenger_type_id, passenger_type_attributes: [:description]

  def index
    @discounts = Discount.includes(:passenger_type).decorate
  end


  def new
    @discount = Discount.new
    @discount.build_passenger_type
  end

  def create
    @discount = Discount.create(discount_params)
    respond_with(@discount, location: discounts_url)
  end

  def update
    @discount.update(discount_params)
    respond_with(@discount, location: discounts_url)
  end

  def destroy
    @discount.destroy
    respond_with(@discount, location: discounts_url)
  end

  private
    def set_discount
     @discount = Discount.find(params[:id])
    end
end
