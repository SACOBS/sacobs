class DiscountParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:discount).permit(discount_attributes, passenger_type_attributes).merge(additional_attr)
  end

  private
   def discount_attributes
    [ :percentage ]
   end

   def passenger_type_attributes
     [ passenger_type_attributes: [:description] ]
   end
end