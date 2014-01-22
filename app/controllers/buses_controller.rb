class BusesController < ApplicationController
  before_action :set_bus, only: [:edit ,:show, :destroy, :update]

  def index
    @q = Bus.search(params[:q])
    @buses = @q.result(distinct: true)
  end

  def update
    @bus.update(bus_params)
    respond_with @bus
  end

  def destroy
    @bus.destroy
    respond_with(@bus)
  end

  private
   def set_bus
    @bus = Bus.find(params[:id])
   end

   def bus_params
     BusParameters.new(params).permit
   end
end