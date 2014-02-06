class PaymentTypesController < ApplicationController
  before_action :set_payment_type, only: [:destroy]

  def index
   @payment_types = PaymentType.all
  end

  def create
   @payment_type = PaymentType.create(payment_type_params)
   respond_with @payment_type, location: payment_types_url
  end

  def destroy
    @payment_type.destroy
    respond_with @payment_type
  end


  private
   def payment_type_params
     params.require(:payment_type).permit(:description)
   end

   def set_payment_type
     @payment_type = PaymentType.find(params[:id])
   end
end