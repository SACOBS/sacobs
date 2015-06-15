class BookingDecorator < LittleDecorator
  def row_class
    row_class_for(record)
  end

  def client_title
    decorate(client).title
  end

  def client_full_name
    decorate(client).full_name
  end

  def client_home_no
    decorate(client).home_no
  end

  def client_work_no
    decorate(client).work_no
  end

  def client_cell_no
    decorate(client).cell_no
  end

  def trip_name
    decorate(trip).name
  end

  def trip_start_date
    decorate(trip).start_date
  end

  def connection
    content_tag(:span, stop.name, class: 'label label-inverse')
  end

  def price
    number_to_currency(invoice.total)
  end

  def status
    status_label_for(record)
  end

  def quantity
    badge_for(record.quantity)
  end

  def created_at
    local_date(record.created_at)
  end

  def client_link(opts = {})
    link_to record.client, opts do
      content_tag(:em, client.full_name)
    end
  end

  def archived_show_link(opts = {})
    opts.merge!(icon: :info)
    link_to 'Show', bookings_archive_path(record), opts
  end

  def cancel_link(opts = {})
    return if cancelled?
    opts.merge!(icon: :warning, method: :patch)
    link_to 'Cancel', cancel_booking_path(record), opts
  end

  def confirmation_link(opts = {})
    return unless reserved?
    opts.merge!(icon: :money)
    link_to 'Confirm', new_booking_payment_detail_url(record), opts
  end

  def destroy_link(opts = {})
    return unless cancelled?
    opts.merge!(method: :delete, icon: :times)
    link_to 'Destroy', record, opts
  end

  def show_link(opts = {})
    opts.merge!(icon: :info)
    link_to 'Show', record, opts
  end

  def ticket_link(opts = {})
    return unless paid? || reserved?
    opts.merge!(icon: :tasks)
    link_to 'Ticket', ticket_path(record), opts
  end
end
