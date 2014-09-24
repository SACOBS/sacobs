class ClientPresenter


  def high_risk
    client.high_risk? ? 'Yes' : 'No'
  end

  def home_telephone
    return 'N/A' unless client.home_no?
    @view_context.number_to_phone(client.home_no, area_code: true)
  end

  def work_telephone
    return 'N/A' unless client.work_no?
    @view_context.number_to_phone(client.work_no, area_code: true)
  end

  def cellphone
    return 'N/A' unless client.cell_no?
    @view_context.number_to_phone(client.cell_no, area_code: true)
  end

  def email
    return 'N/A' unless client.email?
    @view_context.mail_to(client.email)
  end

  def bank
    client.bank_name.presence || 'Not Applicable'
  end
end