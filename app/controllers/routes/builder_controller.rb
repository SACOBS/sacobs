module Routes
  class BuilderController < ApplicationController
    include Wicked::Wizard

    layout 'wizard'

    steps :details, :destinations, :connections

    def show
      case step
        when :details
          @route = Route.new
          session[:route] = nil
        when :destinations
          @route = Route.new(session[:route])
        when :connections
          @route = Route.find(session[:route])
      end
      render_wizard
    end

    def update
      case step
        when :details
          @route = Route.new(route_params)
          if @route.valid?
            session[:route] = route_params
            redirect_to next_wizard_path
          else
            render :details
          end
        when :destinations
          @route = Route.new(session[:route].merge(route_params))
          if @route.save
            session[:route] = @route.id
            redirect_to next_wizard_path
          else
            render :destinations
          end
        when :connections
          @route = Route.find(session[:route])
          if @route.update(route_params)
            session[:route] = nil
            redirect_to @route
          else
            render :connections
          end
      end
    end

    private
    def route_params
      params.fetch(:route, {}).permit(:name, :cost, :distance,
                                      destinations_attributes: [:city_id, :sequence,  :_destroy],
                                      connections_attributes: [:id, :_destroy,  :distance, :percentage, :cost, :depart, :arrive,
                                                               :from_id, :to_id]
                                     ).merge(user_id: current_user.id)
    end
  end
end
