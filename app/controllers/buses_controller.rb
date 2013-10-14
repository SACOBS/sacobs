class BusesController < ApplicationController
  before_action :set_bus, only: [:edit,:update, :destroy]

  params_for :bus, :name, :capacity, :year, :model, seats_attributes: [:id, :_destroy, :row, :number]

  def index
    @buses = Bus.all
  end

  def new
    @bus = Bus.new
  end

  def create
    @bus = Bus.new(bus_params)
    create_seats if @bus.save
    respond_with(@bus, location: edit_bus_url(@bus))
  end

  def update
    @bus.update(bus_params)
    respond_with(@bus, location: buses_url)
  end

  def destroy
    @bus.destroy
    respond_with(@bus)
  end

  private
  def set_bus
   @bus = Bus.find(params[:id])
  end

  def create_seats
    @bus.capacity.times { @bus.seats.create }
  end
end