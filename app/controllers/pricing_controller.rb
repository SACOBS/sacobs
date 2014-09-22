class PricingController < ApplicationController

  def index
    @connections = Connection.order(:name).select(:id, :name, :route_id, :cost)
    @pricing = PricingDecorator.new(@connections.first)
    render layout: 'with_sidebar'
  end

  def show
    @connection =  Connection.find(params[:id])
    @pricing = PricingDecorator.new(@connection)
    respond_with @pricing
  end

  private
    def search_params
      params[:q] ||= {}
      params[:q].delete_if { |key, value| value.blank? }
    end
end
