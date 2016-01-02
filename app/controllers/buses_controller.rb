# == Schema Information
#
# Table name: buses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  capacity   :integer          default(0)
#  year       :string(255)
#  model      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class BusesController < ApplicationController
  before_action :set_bus, only: [:edit, :show, :destroy, :update]
  before_action :build_bus, only: [:new, :create]

  def index
    @buses = Bus.search(params[:q]).result
  end

  def show
    fresh_when @bus
  end

  def create
    @bus.save
    respond_with(@bus)
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

  def build_bus
    @bus = Bus.new(bus_params)
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
