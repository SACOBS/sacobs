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
    bank_name.presence || 'Not Applicable'
  end


  def show_link(options={})
    helpers.link_to 'Show', model, options
  end

  def edit_link(options={})
    helpers.link_to 'Edit', helpers.edit_client_path(model), options
  end

  def destroy_link(options={})
    options.merge!(method: :delete, data: { confirm: helpers.t('messages.confirm', resource: :client)})
    helpers.link_to 'Destroy', model, options
  end
end