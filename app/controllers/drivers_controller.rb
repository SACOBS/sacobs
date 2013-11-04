class DriversController < ApplicationController
  before_action :set_driver, only: [:show, :edit, :update, :destroy]

  params_for :driver, :name, :surname

  # GET /drivers
  # GET /drivers.json
  def index
    @drivers = Driver.all
  end


  # GET /drivers/new
  def new
    @driver = Driver.new
  end


  # POST /drivers
  # POST /drivers.json
  def create
    @driver = Driver.create(driver_params)
    respond_with(@driver, location: drivers_url)
  end

  # PATCH/PUT /drivers/1
  # PATCH/PUT /drivers/1.json
  def update
    @driver.update(driver_params)
    respond_with(@driver, location: drivers_url)
  end

  # DELETE /drivers/1
  # DELETE /drivers/1.json
  def destroy
    @driver.destroy
    respond_with(@driver)
  end

  private
    def set_driver
      @driver = Driver.friendly.find(params[:id])
    end

    def interpolation_options
      { resource_name: @driver.full_name }
    end
end
