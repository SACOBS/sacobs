class TripsheetPresenter
  delegate :bookings, :bus_name, to: :trip

  def initialize(trip, view_context)
    @trip = trip
    @view_context = view_context
  end

  def trip_name
    @trip.name.titleize
  end

  def current_date
    helpers.l(Time.zone.now)
  end

  def drivers_names
    @trip.drivers.map(&:name)
  end

  def notes
    @view_context.simple_format(@trip.notes)
  end

  def trip_sheet_note1
    @view_context.simple_format(settings.trip_sheet_note1)
  end

  def trip_sheet_note2
    @view_context.simple_format(settings.trip_sheet_note2)
  end

  def trip_sheet_note3
    @view_context.simple_format(settings.trip_sheet_note3)
  end

  def trip_sheet_note4
    @view_context.simple_format(settings.trip_sheet_note4)
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
