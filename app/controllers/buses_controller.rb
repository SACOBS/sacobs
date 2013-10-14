class BusesController < ApplicationController
  before_action :set_bus, only: [:show, :destroy]

  def index
    @buses = Bus.all
  end

  def destroy
    @bus.destroy
    respond_with(@bus)
  end

  private
  def set_bus
   @bus = Bus.find(params[:id])
  end
end