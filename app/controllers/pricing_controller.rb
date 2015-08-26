class PricingController < ApplicationController
  def index
    @connections = Connection.order(:name).select(:id, :name, :route_id, :cost)
    @pricing = PricingPresenter.new(@connections.first)
    render layout: 'with_sidebar'
  end

  def show
    connection = Connection.find(params[:id])
    @pricing = PricingPresenter.new(connection)
  end
end
