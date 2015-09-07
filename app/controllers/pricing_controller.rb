class PricingController < ApplicationController
  def index
    @connections = Connection.order(:name).select(:id, :name, :route_id, :cost)
    @pricing = PricingPresenter.new(@connections.first)
  end

  def show
    connection = Connection.find(params[:id])
    @pricing = PricingPresenter.new(connection)
  end
end
