# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class DriversController < ApplicationController
  before_action :set_driver, only: [:edit, :update, :destroy]

  def index
    @drivers = Driver.all
    respond_with(@drivers) if stale?(@drivers)
  end

  def search
    @drivers = Driver.search(params[:q]).result(distinct: true)
    respond_with(@drivers)
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.create(driver_params)
    respond_with @driver, location: drivers_url
  end

  def update
    @driver.update(driver_params)
    respond_with @driver, location: drivers_url
  end

  def destroy
    @driver.destroy
    respond_with @driver
  end

  private
  def set_driver
    @driver = Driver.find(params[:id])
  end

  def driver_params
    params.fetch(:driver, {}).permit(:name, :surname).merge(user_id: current_user.id)
  end

  def interpolation_options
    { resource_name: @driver.full_name }
  end
end
