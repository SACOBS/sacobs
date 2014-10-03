class VoucherParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:voucher).permit(voucher_attributes).merge(additional_attr)
  end

  private

  def voucher_attributes
    [:amount]
  end
end
