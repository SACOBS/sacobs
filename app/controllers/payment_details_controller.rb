class PaymentDetailsController < ApplicationController

  before_action :set_booking

  def new
    @payment_detail = @booking.build_payment_detail
  end

  def create
    @payment_detail = @booking.create_payment_detail(payment_details_params)
    respond_with @payment_detail, location: booking_url(@booking)
  end

  private
   def set_booking
     @booking = Booking.find(params[:booking_id])
   end

   def payment_details_params
     PaymentDetailParameters.new(params).permit(user: current_user)
   end
end
