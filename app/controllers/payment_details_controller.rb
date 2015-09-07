class PaymentDetailsController < ApplicationController
  before_action :set_booking

  def new
    @payment_detail = PaymentDetail.new(booking: @booking)
  end

  def create
    @payment_detail = @booking.build_payment_detail(payment_details_params)
    if @payment_detail.valid?
      ConfirmBooking.new(@booking, current_user).perform(payment_details_params)
      redirect_to booking_url(@booking), notice: 'Booking has been successfully confirmed.'
    else
      render :new
    end
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def payment_details_params
    params.fetch(:payment_detail, {}).permit(:booking_id,
                                             :paid_at,
                                             :payment_type,
                                             :reference
                                            ).merge(user_id: current_user.id)
  end
end
