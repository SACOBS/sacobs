class VouchersController < ApplicationController
  before_action :set_client, only: [:new, :create]

  params_for :voucher, :amount

  def new
    @voucher = @client.vouchers.new
  end

  def create
    @voucher = @client.vouchers.create(voucher_params)
    respond_with(@client, @voucher, location: client_url(@client))
  end

  private
   def set_client
     @client = Client.friendly.find(params[:client_id])
   end
end
