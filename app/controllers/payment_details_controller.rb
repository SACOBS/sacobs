# == Schema Information
#
# Table name: payment_details
#
#  id           :integer          not null, primary key
#  paid_at      :datetime
#  reference    :string(255)
#  user_id      :integer
#  payment_type :string(255)
#

class PaymentDetailsController < ApplicationController
  before_action :set_booking

  def new
    @payment_detail = PaymentDetail.new
  end

  def create
    @payment_detail = PaymentDetail.new(payment_details_params)
    @payment_detail.bookings = [@booking, @booking.main, @booking.return_booking].compact
    @payment_detail.user_id = current_user.id
    if @payment_detail.save
      Booking::Confirm.perform(@booking, current_user)
      redirect_to booking_url(@booking), notice: "Booking has been successfully confirmed."
    else
      render :new
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def payment_details_params
    params.fetch(:payment_detail, {}).permit(:paid_at,
                                             :payment_type,
                                             :reference)
  end
end
