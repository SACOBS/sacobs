# == Schema Information
#
# Table name: charges
#
#  id          :integer          not null, primary key
#  percentage  :decimal(5, 2)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#

class ChargesController < ApplicationController
  before_action :set_charge, only: %i(edit update destroy)

  def index
    @charges = Charge.all
  end

  def new
    @charge = Charge.new
  end

  def create
    @charge = Charge.create(charge_params)
    respond_with @charge, location: charges_url
  end

  def update
    @charge.update(charge_params)
    respond_with @charge, location: charges_url
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
    params.fetch(:charge, {}).permit(:percentage, :description).merge(user_id: current_user.id)
  end
end
