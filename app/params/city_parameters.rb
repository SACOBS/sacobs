class CityParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:city).permit(city_attributes, venues_attributes).merge(additional_attr)
  end

  private
   def city_attributes
     [:name]
   end

   def venues_attributes
     { venues_attributes: [:id, :name, :_destroy] }
   end
end