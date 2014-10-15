class PaymentDetailsController < ApplicationController
  before_action :set_booking

  def new
    @payment_detail = @booking.build_payment_detail(payment_type: find_payment_type)
  end

  def create
    @booking.create_payment_details(payment_details_params)
    respond_with @booking.payment_detail, location: bookings_url
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def find_payment_type
    return unless @booking.client_bank_name
    PaymentType.find_by(description: @booking.client_bank_name)
  end

  def payment_details_params
    params.fetch(:payment_detail, {}).permit(:booking_id,
                                             :payment_date,
                                             :payment_type_id,
                                             :reference
    )
  end
end
