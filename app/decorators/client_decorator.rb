class ClientDecorator < Draper::Decorator
  delegate_all

  def telephone
   return 'N/A' unless tel_no.present?
   h.number_to_phone(tel_no)
  end

  def cellphone
    return 'N/A' unless cell_no.present?
    h.number_to_phone(cell_no)
  end

  def email
    return 'N/A' unless model.email.present?
    h.mail_to(model.email)
  end

  def edit_link
    h.link_to 'Edit', edit_path, icon: :edit, class: 'btn btn-info'
  end

  def destroy_link
   h.link_to 'Destroy', destroy_path , method: :delete, data: { confirm: 'Are you sure you want to delete this client?' }, icon: :times, class: 'btn btn-danger'
  end

  private
  def edit_path
    h.edit_client_path(model)
  end

  def destroy_path
    h.client_path(model)
  end
end
