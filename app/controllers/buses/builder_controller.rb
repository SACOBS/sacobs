module Buses
  class BuilderController < ApplicationController
    include Wicked::Wizard

    layout 'wizard'

    before_action :set_bus, only: [:show, :update]

    steps :bus_details, :seats

    def create
      @bus = Bus.create
      redirect_to wizard_path(Wicked::FIRST_STEP, bus_id: @bus)
    end

    def show
      build_seats if step == :seats
      render_wizard
    end

    def update
      @bus.update(bus_params)
      render_wizard @bus
    end

    private

    def finish_wizard_path
      buses_url
    end

    def set_bus
      @bus = Bus.find(params[:bus_id])
    end

    def build_seats
      @bus.seats.clear
      @bus.capacity.times { seats.build }
    end

    def bus_params
      BusParameters.new(params).permit(user: current_user)
    end
  end
end
