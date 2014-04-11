class PaymentDetailsController < ApplicationController

  before_action :set_booking

  def new
    @payment_detail = @booking.build_payment_detail(payment_type: find_payment_type)
  end

  def create
    @payment_detail = @booking.create_payment_detail(payment_details_params)
    if @payment_detail.valid?
      if @booking.is_return?
        @booking.main.create_payment_detail(payment_details_params)  if @booking.main
      else
        @booking.return_booking.create_payment_detail(payment_details_params) if @booking.return_booking
      end
    end
    respond_with @payment_detail, location: bookings_url
  end

  private
   def set_booking
     @booking = Booking.find(params[:booking_id])
   end

   def find_payment_type
     return unless @booking.client.bank
     PaymentType.find_by(description: @booking.client.bank.name)
   end

   def payment_details_params
     PaymentDetailParameters.new(params).permit(user: current_user)
   end


end
