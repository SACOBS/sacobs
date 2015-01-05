class DriversController < ApplicationController
  before_action :set_driver, only: [:show, :edit, :update, :destroy]

  def index
    @drivers = driver_scope
  end

  def search
    @drivers = driver_scope.search(params[:q]).result(distinct: true)
    render partial: 'driver', collection: @drivers, cache: true
  end

  def new
    @driver = Driver.new
  end

  def show
    fresh_when @driver, last_modified: @driver.updated_at
  end

  def create
    @driver = Driver.create(driver_params)
    respond_with @driver
  end

  def update
    @driver.update(driver_params)
    respond_with @driver
  end

  def destroy
    @driver.destroy
    respond_with @driver
  end

  private

  def driver_scope
    @driver_scope ||= Driver.all
  end

  def set_driver
    @driver = Driver.friendly.find(params[:id])
  end

  def driver_params
    params.fetch(:driver, {}).permit(:name, :surname).merge(user: current_user)
  end

  def interpolation_options
    { resource_name: @driver.full_name }
  end
end
