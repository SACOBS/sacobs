class PassengerDecorator < BaseDecorator
  def passenger_type_description
    model.passenger_type_description.capitalize
  end

  def cellphone
    return 'N/A' unless cell_no?
    @view_context.number_to_phone(cell_no, area_code: true)
  end

  def email
    return 'N/A' unless email?
    @view_context.mail_to(model.email)
  end
end
