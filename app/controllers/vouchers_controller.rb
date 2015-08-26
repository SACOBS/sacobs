class VouchersController < ApplicationController
  before_action :set_client, only: [:new, :create]

  def new
    @voucher = @client.vouchers.new
  end

  def create
    @voucher = @client.vouchers.create(voucher_params)
    respond_with @client, @voucher, location: client_url(@client)
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def voucher_params
    params.fetch(:voucher, {}).permit(:amount).merge(user_id: current_user.id)
  end
end
