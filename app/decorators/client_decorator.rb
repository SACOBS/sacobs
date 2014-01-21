class ClientDecorator < Draper::Decorator
  delegate_all

  def high_risk
    model.high_risk? ? 'Yes' : 'No'
  end

  def telephone
   return 'N/A' unless tel_no.present?
   h.number_to_phone(tel_no, area_code: true)
  end

  def cellphone
    return 'N/A' unless cell_no.present?
    h.number_to_phone(cell_no, area_code: true)
  end

  def email
    return 'N/A' unless model.email.present?
    h.mail_to(model.email)
  end

  def modifier
    model.try(:user)
  end
end
