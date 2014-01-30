class SeasonalMarkupParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:seasonal_markup).permit(seasonal_markup_attributes).merge(additional_attr)
  end

  private
  def seasonal_markup_attributes
    [ :percentage, :period_from, :period_to, :active ]
  end
end