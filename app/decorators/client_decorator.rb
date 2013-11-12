class ClientDecorator < Draper::Decorator
  delegate_all

  def telephone
   return 'N/A' unless tel_no.present?
   h.number_to_phone(tel_no, area: true)
  end

  def cellphone
    return 'N/A' unless cell_no.present?
    h.number_to_phone(cell_no, area: true)
  end

  def email
    return 'N/A' unless model.email.present?
    h.mail_to(model.email)
  end

  def modifier
    User.find(model.user_id)
  end
end
