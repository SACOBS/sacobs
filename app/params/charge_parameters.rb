class ChargeParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:charge).permit(charge_attributes).merge(additional_attr)
  end

  private

  def charge_attributes
    [:percentage, :description]
  end
end
