class TripsheetPresenter
  delegate :bus_name, :drivers_names, :stops, to: :trip

  def initialize(trip, view_context, settings)
    @trip = trip
    @view_context = view_context
    @settings = settings
  end

  def bookings
    trip.bookings.includes(:stop, :passengers)
  end

  def bus_capacity
    trip.bus.capacity
  end

  def trip_name
    trip.name.titleize
  end

  def current_date
    view_context.l(Date.current, format: :long)
  end

  def notes
    view_context.simple_format(trip.notes)
  end

  def trip_sheet_note1
    view_context.simple_format(@settings.trip_sheet_note1)
  end

  def trip_sheet_note2
    view_context.simple_format(@settings.trip_sheet_note2)
  end

  def trip_sheet_note3
    view_context.simple_format(@settings.trip_sheet_note3)
  end

  def trip_sheet_note4
    view_context.simple_format(@settings.trip_sheet_note4)
  end

  private

  attr_reader :trip, :view_context
end
