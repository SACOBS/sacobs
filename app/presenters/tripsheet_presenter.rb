class TripsheetPresenter

  def initialize(trip, view_context)
    @trip = trip
    @view_context = view_context
  end

  def bookings
    trip.bookings.includes(:stop, :passengers)
  end

  def stops
    trip.stops
  end

  def bus_name
    trip.bus.name
  end

  def bus_capacity
    trip.bus.capacity
  end

  def trip_name
    trip.name.titleize
  end

  def current_date
    l(Date.current, format: :long)
  end

  def drivers_names
    trip.drivers.map(&:name)
  end

  def notes
    simple_format(trip.notes)
  end

  def trip_sheet_note1
    simple_format(settings.trip_sheet_note1)
  end

  def trip_sheet_note2
    simple_format(settings.trip_sheet_note2)
  end

  def trip_sheet_note3
    simple_format(settings.trip_sheet_note3)
  end

  def trip_sheet_note4
    simple_format(settings.trip_sheet_note4)
  end


  def method_missing(method_name, *args, &block)
    return @view_context.public_send(method_name, *args, &block) if @view_context.respond_to?(method_name)
    super
  end

  def respond_to_missing?(method_name, include_private=false)
    @view_context.respond_to?(method_name, include_private)
  end

  private

  attr_reader :trip

  def settings
    @settings ||= Setting.first
  end
end
