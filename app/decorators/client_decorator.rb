class ClientDecorator < BaseDecorator

  def high_risk
    high_risk? ? 'Yes' : 'No'
  end

  def home_telephone
    return 'N/A' unless home_no?
    helpers.number_to_phone(home_no, area_code: true)
  end

  def work_telephone
    return 'N/A' unless work_no?
    helpers.number_to_phone(work_no, area_code: true)
  end

  def cellphone
    return 'N/A' unless cell_no?
    helpers.number_to_phone(cell_no, area_code: true)
  end

  def email
    return 'N/A' unless email?
    helpers.mail_to(model.email)
  end

  def bank
    client.bank_name.presence || 'Not Applicable'
  end
end