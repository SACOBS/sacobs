class BusParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.fetch(:bus, {}).permit(bus_attributes, seats_attributes).merge(additional_attr)
  end

  private
   def bus_attributes
    [ :name, :capacity, :year, :model ]
   end

   def seats_attributes
     { seats_attributes: [:id, :_destroy, :row, :number] }
   end


end