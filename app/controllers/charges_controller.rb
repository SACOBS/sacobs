class ChargesController < ApplicationController
  before_action :set_charge, only: [:edit, :update, :destroy]

  def index
    @charges = Charge.decorate
  end


  def new
    @charge = Charge.new
  end

  def create
    @charge = Charge.create(charge_params)
    respond_with(@charge, location: charges_url)
  end

  def update
    @charge.update(charge_params)
    respond_with(@charge, location: charges_url)
  end

  def destroy
    @charge.destroy
    respond_with(@charge, location: charges_url)
  end

  private
  def set_charge
    @charge = Charge.find(params[:id])
  end

  def charge_params
   ChargeParameters.new(params).permit(user: current_user)
  end
end