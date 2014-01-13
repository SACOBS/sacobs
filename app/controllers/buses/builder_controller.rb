class Buses::BuilderController < ApplicationController
  include Wicked::Wizard

  before_action :set_bus, only: [:destroy, :show, :update]

  steps :details, :seats

  def create
    @bus = Bus.create
    redirect_to wizard_path(Wicked::FIRST_STEP, bus_id: @bus)
  end

  def show
    case step
     when :seats
       build_seats
    end
    render_wizard
  end

  def update
    @bus.update(bus_params)
    render_wizard @bus
  end

  def destroy
    @bus.destroy if @bus.empty?
    redirect_to_finish_wizard
  end

  private
    def finish_wizard_path
      buses_url
    end

    def set_bus
      @bus =  Bus.find(params[:bus_id])
    end

    def build_seats
      (@bus.capacity - @bus.seats.size).times { @bus.seats.build }
    end

    def bus_params
      params.require(:bus).permit(:name,
                                  :capacity,
                                  :year,
                                  :model,
                                  seats_attributes: [:id, :_destroy, :row, :number]).merge(user: current_user)
    end
end
