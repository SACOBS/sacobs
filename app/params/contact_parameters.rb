class ContactParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.require(:contact).permit(contact_attributes).merge(additional_attr)
  end

  private

  def contact_attributes
    [:name, :email, :message, :nickname]
  end
end
