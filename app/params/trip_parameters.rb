class TripParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:trip).permit(trip_attributes, stops_attributes).merge(additional_attr)
  end

  private
   def trip_attributes
    [ :name, :start_date, :end_date, :route_id ,:bus_id, driver_ids: []]
   end

   def stops_attributes
     { stops_attributes: [:id, :arrive, :depart, :_destroy, :connection_id, :available_seats] }
   end
end