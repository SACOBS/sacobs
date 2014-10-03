class ClientParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.fetch(:client, {}).permit(client_attributes, address_attributes).merge(additional_attr)
  end

  private

  def client_attributes
    [:title, :name, :surname, :date_of_birth, :high_risk, :cell_no, :home_no, :work_no, :email, :bank_id, :notes, :id_number]
  end

  def address_attributes
    { address_attributes: [:id, :street_address1, :street_address2, :city, :postal_code, :_destroy] }
  end
end
