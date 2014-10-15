class ChargesController < ApplicationController
  responders :flash, :collection

  before_action :set_charge, only: [:edit, :update, :destroy]

  def index
    @charges = Charge.all
  end

  def new
    @charge = Charge.new
  end

  def create
    @charge.user = current_user
    @charge = Charge.create(charge_params)
    respond_with @charge
  end

  def update
    @charge.user = current_user
    @charge.update(charge_params)
    respond_with @charge
  end

  def destroy
    @charge.destroy
    respond_with @charge
  end

  private

  def set_charge
    @charge = Charge.find(params[:id])
  end

  def charge_params
    params.fetch(:charge, {}).permit(:percentage, :description)
  end
end
