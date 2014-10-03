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
    @charge = Charge.create(charge_params)
    respond_with @charge
  end

  def update
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
    ChargeParameters.new(params).permit(user: current_user)
  end
end
