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
      @bus.build_seats if step == :seats
      render_wizard
    end

    def update
      save
      render_wizard @bus
    end

    private

    def save
      @bus.user = current_user
      Bus.no_touching { @bus.update(bus_params) }
      @bus.touch
    end

    def finish_wizard_path
      buses_url
    end

    def set_bus
      @bus = Bus.find(params[:bus_id])
    end

    def bus_params
      params.fetch(:bus, {}).permit(:name,
                                    :capacity,
                                    :year,
                                    :model,
                                    seats_attributes: [:id, :_destroy, :row, :number]
      )
    end
  end
end
