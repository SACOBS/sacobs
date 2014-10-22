class TripDecorator < BaseDecorator
  def trip_day
    start_date.strftime('%A')
  end

  def bookings_count
    bookings.size
  end

  def show_link(options = {})
    helpers.link_to 'Show', model, options
  end

  def edit_link(options = {})
    helpers.link_to 'Edit', helpers.edit_trip_path(model), options
  end

  def copy_link(options = {})
    options.merge!(method: :post, data: { toggle: 'tooltip', title: 'Click here to create a copy of this trip.' }, rel: 'tooltip')
    helpers.link_to 'Copy', helpers.copy_trip_path(model), options
  end

  def destroy_link(options = {})
    options.merge!(method: :delete, data: { confirm: helpers.t('messages.confirm', resource: :trip) })
    helpers.link_to_unless(model.bookings.any?, 'Destroy', model, options) {}
  end

  def generate_tripsheet_link(options = {})
    options.merge!(target: '_blank')
    helpers.link_to 'Generate TripSheet', helpers.edit_trip_sheet_path(model), options
  end
end
