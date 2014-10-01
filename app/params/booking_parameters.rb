class BookingParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.fetch(:booking, {}).permit(booking_attributes,
                                    client_attributes,
                                    passenger_attributes,
                                    invoice_attributes,
                                    return_booking_attributes).merge(additional_attr)
  end

  private
   def booking_attributes
     [:trip_id, :price, :status, :quantity, :client_id, :has_return, :stop_id, :id]
   end

   def client_attributes
     { client_attributes: [:id, :_destroy, :title, :name, :surname, :date_of_birth, :high_risk,:cell_no, :home_no, :work_no, :email, :bank_id, :id_number,:notes ,address_attributes: [:id, :street_address1, :street_address2, :city, :postal_code, :_destroy] ] }
   end

   def passenger_attributes
     { passengers_attributes: [:id, :name, :surname, :cell_no, :email ,:passenger_type_id, charge_ids: []] }
   end

   def invoice_attributes
     { invoice_attributes: [:id, :billing_date, line_items_attributes: [:id,:description, :amount, :line_item_type]] }
   end

   def return_booking_attributes
     { return_booking_attributes: [:stop_id, :quantity, :trip_id, :id, invoice_attributes] }
   end
end