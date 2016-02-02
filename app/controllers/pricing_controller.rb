class PricingController < ApplicationController
  def index
    @connections = Connection.order(:name).select(:id, :name, :route_id, :cost)
  end

  def show
    connection = Connection.find(params[:id])
    @pricing = PricingPresenter.new(connection)
    render partial: 'quote', locals: { pricing: @pricing }
  end
end
