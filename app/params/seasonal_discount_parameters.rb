class SeasonalDiscountParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:seasonal_discount).permit(seasonal_markup_attributes).merge(additional_attr)
  end

  private
  def seasonal_markup_attributes
    [ :passenger_type_id, :percentage, :period_from, :period_to, :active ]
  end
end