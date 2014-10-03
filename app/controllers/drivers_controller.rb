class DriversController < ApplicationController
  before_action :set_driver, only: [:show, :edit, :update, :destroy]

  # GET /drivers
  # GET /drivers.json
  def index
    @q = Driver.search(params[:q])
    @drivers = @q.result(distinct: true)
  end

  # GET /drivers/new
  def new
    @driver = Driver.new
  end

  def show
    fresh_when @driver, last_modified: @driver.updated_at
  end

  # POST /drivers
  # POST /drivers.json
  def create
    @driver = Driver.create(driver_params)
    respond_with @driver
  end

  # PATCH/PUT /drivers/1
  # PATCH/PUT /drivers/1.json
  def update
    @driver.update(driver_params)
    respond_with @driver
  end

  # DELETE /drivers/1
  # DELETE /drivers/1.json
  def destroy
    @driver.destroy
    respond_with @driver
  end

  private

  def set_driver
    @driver = Driver.friendly.find(params[:id])
  end

  def driver_params
    DriverParameters.new(params).permit(user: current_user)
  end

  def interpolation_options
    { resource_name: @driver.full_name }
  end
end
