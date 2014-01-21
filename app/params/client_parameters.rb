class ClientParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:client).permit(client_attributes, address_attributes).merge(additional_attr)
  end

  private
   def client_attributes
    [ :name, :surname, :high_risk ,:cell_no,:tel_no, :email ]
   end

   def address_attributes
    { address_attributes: [:id, :street_address1, :street_address2, :city, :postal_code, :_destroy] }
   end
end
