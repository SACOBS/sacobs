class BusesController < ApplicationController
  before_action :set_bus, only: [:edit, :show, :destroy, :update]

  def index
    @q = Bus.search(params[:q])
    @buses = @q.result(distinct: true)
  end

  def show
    fresh_when @bus, last_modified: @bus.updated_at
  end

  def update
    @bus.update(bus_params)
    respond_with @bus
  end

  def destroy
    @bus.destroy
    respond_with @bus
  end

  private

  def set_bus
    @bus = Bus.find(params[:id])
  end

  def bus_params
      params.fetch(:bus, {}).permit(:name,
                                    :capacity,
                                    :year,
                                    :model,
                                    seats_attributes: [:id, :_destroy, :row, :number]
      ).merge(user_id: current_user.id)
  end
end
