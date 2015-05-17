module Buses
  class BuilderController < ApplicationController
    include Wicked::Wizard

    layout 'wizard'

    steps :details, :seats

    def show
      case step
        when :details
          @bus = Bus.new
          session[:bus] = nil
        when :seats
          @bus = Bus.new(session[:bus])
          @bus.build_seats
      end
      render_wizard
    end

    def update
      case step
        when :details
          @bus = Bus.new(bus_params)
          if @bus.valid?
            session[:bus] = bus_params
            redirect_to next_wizard_path
          else
            render :details
          end
        when :seats
          @bus = Bus.new(session[:bus].merge(bus_params))
          if @bus.save
            session[:bus] = nil
            redirect_to @bus
          else
            render :seats
          end
      end
    end

    private

    def bus_params
      params.fetch(:bus, {}).permit(:name,
                                    :capacity,
                                    :year,
                                    :model,
                                    seats_attributes: [:id, :_destroy, :row, :number]
                                   ).merge(user_id: current_user.id)
    end
  end
end
