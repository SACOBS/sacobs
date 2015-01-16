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

  def contact_numbers
    [helpers.number_to_phone(cell_no, area_code: true), helpers.number_to_phone(work_no, area_code: true), helpers.number_to_phone(home_no, area_code: true)].compact.reject(&:empty?).join(', ')
  end

  def email
    return 'N/A' unless email?
    helpers.mail_to(model.email)
  end

  def bank
    model.bank.presence || 'Not Applicable'
  end

  def show_link(options = {})
    text = options.fetch(:text, 'Show')
    helpers.link_to text, model, options
  end

  def edit_link(options = {})
    text = options.fetch(:text, 'Edit')
    helpers.link_to text, helpers.edit_client_path(model), options
  end

  def destroy_link(options = {})
    text = options.fetch(:text, 'Destroy')
    options.deep_merge!(method: :delete, data: { confirm: helpers.t('messages.confirm', resource: :client) })
    helpers.link_to text, model, options
  end
end
