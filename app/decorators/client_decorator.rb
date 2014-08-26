class ClientDecorator < Draper::Decorator
  delegate_all

  def high_risk
    model.high_risk? ? 'Yes' : 'No'
  end

  def home_telephone
    return 'N/A' unless home_no.present?
    h.number_to_phone(home_no, area_code: true)
  end

  def work_telephone
    return 'N/A' unless work_no.present?
    h.number_to_phone(work_no, area_code: true)
  end

  def cellphone
    return 'N/A' unless cell_no.present?
    h.number_to_phone(cell_no, area_code: true)
  end

  def email
    return 'N/A' unless model.email.present?
    h.mail_to(model.email)
  end

  def bank
    model.bank_name.presence || 'Not Applicable'
  end

  def modifier
    model.try(:user) || model.user.email
  end
end
