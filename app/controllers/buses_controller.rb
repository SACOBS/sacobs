class BusesController < ApplicationController

  params_for :bus, :name, :capacity, :year, :model, seats_attributes: [:id, :_destroy, :row, :number]

  def index
    @buses = Bus.all
  end

  def edit
    @bus = find_bus(params[:id])
  end

  def new
    @bus = build_bus
  end

  def create
    @bus = build_bus
    create_seats if @bus.save
    respond_with(@bus, location: edit_bus_url(@bus))
  end

  def update
    @bus = find_bus(params[:id])
    @bus.update(bus_params)
    respond_with(@bus, location: bus_url)
  end

  def destroy
    @bus = find_bus(params[:id])
    @bus.destroy
    respond_with(@bus)
  end

  private
  def build_bus
    Bus.new(bus_params)
  end

  def find_bus(id)
    Bus.find(params[:id])
  end

  def create_seats
    @bus.capacity.times { @bus.seats.create }
  end
end