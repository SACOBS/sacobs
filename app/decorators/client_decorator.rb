class ClientDecorator < LittleDecorator
  def recent_bookings
    decorate(bookings.recent)
  end

  def title
    record.title.upcase
  end

  def bank
    return 'N/A' unless record.bank.present?
    record.bank
  end

  def high_risk
    record.high_risk? ? 'Yes' : 'No'
  end

  def notes
    return 'N/A' unless record.notes.present?
    simple_format(record.notes)
  end

  def age
    return 'N/A' unless record.age.present?
    record.age
  end

  def date_of_birth
    return 'N/A' unless record.date_of_birth.present?
    local_date(record.date_of_birth)
  end

  def email
    return 'N/A' unless record.email.present?
    mail_to(record.email)
  end

  def street_address1
    return 'N/A' unless record.street_address1.present?
    record.street_address1
  end

  def street_address2
    return 'N/A' unless record.street_address2.present?
    record.street_address2
  end

  def city
    return 'N/A' unless record.city.present?
    record.city
  end

  def postal_code
    return 'N/A' unless record.postal_code.present?
    record.postal_code
  end

  def home_no
    return 'N/A' unless record.home_no.present?
    number_to_phone(record.home_no, area_code: true)
  end

  def work_no
    return 'N/A' unless record.work_no.present?
    number_to_phone(record.work_no, area_code: true)
  end

  def cell_no
    return 'N/A' unless record.cell_no.present?
    number_to_phone(record.cell_no, area_code: true)
  end

  def add_voucher_link(opts = {})
    opts.merge!(icon: :money)
    link_to 'Add Credit Voucher', new_client_voucher_path(record), opts
  end

  def show_link(opts = {})
    link_to record, opts do
      fa_icon :info, text: 'Show'
    end
  end

  def edit_link(opts = {})
    link_to edit_client_path(record), opts do
      fa_icon :edit, text: 'Edit'
    end
  end

  def destroy_link(opts = {})
    opts.merge!(method: :delete)
    link_to record, opts do
      fa_icon :times, text: 'Destroy'
    end
  end
end
