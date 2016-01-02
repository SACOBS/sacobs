# == Schema Information
#
# Table name: vouchers
#
#  id         :integer          not null, primary key
#  ref_no     :string(255)
#  amount     :decimal(, )
#  active     :boolean          default(TRUE)
#  client_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#
# Indexes
#
#  index_vouchers_on_client_id  (client_id)
#

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
