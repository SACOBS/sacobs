class PaymentDetailParameters < Struct.new(:params)

  def permit(additional_attr = {})
    params.require(:payment_detail).permit(payment_detail_attributes).merge(additional_attr)
  end

  private
  def payment_detail_attributes
    [:booking_id, :payment_date, :payment_type_id, :reference ]
  end
end