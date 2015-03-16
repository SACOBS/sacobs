class ArchivedTripDecorator < BaseDecorator
  def trip_day
    model.start_date.strftime('%A')
  end

  def bookings_count
    bookings.size
  end

  def start_date
    helpers.l(model.start_date, format: :long)
  end

  def end_date
    helpers.l(model.end_date, format: :long)
  end

  def show_link(options = {})
    helpers.link_to 'Show', helpers.trips_archive_path(model), options
  end

  def generate_tripsheet_link(options = {})
    options.merge!(target: '_blank')
    helpers.link_to 'Generate TripSheet', helpers.trip_sheet_path(model), options
  end
end
