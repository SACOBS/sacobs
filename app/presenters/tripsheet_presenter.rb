class TripsheetPresenter
  def initialize(trip, view_context)
    @trip = trip
    @view_context = view_context
  end

  def bookings
    trip.bookings
  end

  def bus_name
    trip.bus.name
  end

  def bus_capacity
    trip.bus.capacity
  end

  def stops
    trip.stops
  end

  def trip_name
    trip.name.titleize
  end

  def current_date
    helpers.l(Time.zone.now)
  end

  def drivers_names
    trip.drivers.map(&:name)
  end

  def notes
    helpers.simple_format(trip.notes)
  end

  def trip_sheet_note1
    helpers.simple_format(settings.trip_sheet_note1)
  end

  def trip_sheet_note2
    helpers.simple_format(settings.trip_sheet_note2)
  end

  def trip_sheet_note3
    helpers.simple_format(settings.trip_sheet_note3)
  end

  def trip_sheet_note4
    helpers.simple_format(settings.trip_sheet_note4)
  end

  private

  attr_reader :trip

  def settings
    @settings ||= Setting.first
  end

  def helpers
    @view_context
  end
end
