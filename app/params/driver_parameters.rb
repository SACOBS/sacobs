class DriverParameters < Struct.new(:params)

  def permit(additional_attr = {})
    params.require(:driver).permit(driver_attributes).merge(additional_attr)
  end

  private
   def driver_attributes
     [:name, :surname]
   end
end