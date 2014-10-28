class PaymentDetailsController < ApplicationController
  before_action :set_booking

  def new
    @payment_detail = @booking.build_payment_detail(payment_type: find_payment_type)
  end

  def create
    @payment_detail = @booking.build_payment_detail(payment_details_params)
    if valid?(@payment_detail)
      CreatePaymentDetails.new(@booking, payment_details_params).call
      redirect_to booking_url(@booking)
    else
      render :new
    end
  end

  private

  def valid?(payment_detail)
    payment_detail.valid?
    payment_detail.errors.add(:base, 'The reference supplied already exists. Please enter a unique reference.') if PaymentDetail.exists?(reference: @payment_detail.reference)
    payment_detail.errors.empty?
  end

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
