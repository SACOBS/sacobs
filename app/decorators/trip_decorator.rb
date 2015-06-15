class TripDecorator < LittleDecorator
  def day
    l(record.start_date, format: :day)
  end

  def start_date
    local_date(record.start_date)
  end

  def end_date
    local_date(record.end_date)
  end

  def copy_link(opts = {})
    opts.merge!(icon: :copy, method: :post)
    link_to 'Copy', copy_trip_path(record), opts
  end

  def show_link(opts = {})
    opts.merge!(icon: :info)
    link_to 'Show', record, opts
  end

  def edit_link(opts = {})
    return if booked?
    opts.merge!(icon: :edit)
    link_to 'Edit', edit_trip_path(record), opts
  end

  def destroy_link(opts = {})
    return if booked?
    opts.merge!(method: :delete, icon: :times)
    link_to 'Destroy', record, opts
  end

  def trip_sheet_link(opts = {})
    opts.merge!(icon: :road)
    link_to 'TripSheet', trip_sheet_path(record), opts
  end

  def archived_show_link(opts = {})
    opts.merge!(icon: :info)
    link_to 'Show', trips_archive_path(record), opts
  end
end
