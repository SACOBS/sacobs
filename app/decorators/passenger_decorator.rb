class PassengerDecorator < Draper::Decorator
  delegate_all

  def passenger_type
    model.passenger_type.description.capitalize
  end

  def cellphone
    return 'N/A' unless cell_no.present?
    h.number_to_phone(cell_no, area_code: true)
  end

  def email
    return 'N/A' unless model.email.present?
    h.mail_to(model.email)
  end
end
